import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:v_dash_mobile/core/common/view_state/view_state.dart';
import 'package:v_dash_mobile/core/config/config.dart';
import 'package:v_dash_mobile/core/general_helpers/utils/connection_util.dart';
import 'package:v_dash_mobile/core/general_helpers/utils/obd_util.dart';
import 'package:v_dash_mobile/features/dashboard/repository/dashboard_repository.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository repository;

  DashboardCubit({required this.repository}) : super(DashboardState.initial()) {
    _listenToConnectivity();
  }

  static const Duration _obdConnectionTimeout = Duration(seconds: 3);
  static const Duration _obdResponseTimeout = Duration(seconds: 1);
  static const Duration _obdRequestDelay = Duration(milliseconds: 50);

  static const List<_ObdCommand> _obdCommands = [
    _ObdCommand(command: '010D', index: 0, name: 'Speed'),
    _ObdCommand(command: '010C', index: 1, name: 'RPM'),
    _ObdCommand(command: '0105', index: 2, name: 'Coolant Temperature'),
    _ObdCommand(command: '0111', index: 3, name: 'Throttle'),
    _ObdCommand(command: '0104', index: 4, name: 'Engine Load'),
    _ObdCommand(command: '0142', index: 5, name: 'Voltage'),
  ];

  final List<Timer?> _itemSimulationTimers = List<Timer?>.filled(6, null);
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  Socket? _obdSocket;
  String _obdBuffer = '';
  int _obdCommandIndex = 0;
  bool _waitingForResponse = false;
  Timer? _obdResponseTimeoutTimer;
  final CancelToken _cancelToken = CancelToken();

  void _listenToConnectivity() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      result,
    ) async {
      emit(state.copyWith(stateDashboard: ViewState.loading));

      final isWifiConnected = result.contains(ConnectivityResult.wifi);

      if (isWifiConnected) {
        final wifiGateway = await ConnectionUtil.getWifiGateway();

        if (wifiGateway == '10.0.2.2') {
          await connectToObd();
        } else {
          emit(state.copyWith(stateDashboard: ViewState.error));
          updateConnectionStatus(false);
        }
      } else {
        disconnectFromObd();
      }
    });
  }

  @override
  Future<void> close() {
    _cancelToken.cancel();
    _connectivitySubscription?.cancel();

    disconnectFromObd();

    for (final timer in _itemSimulationTimers) {
      timer?.cancel();
    }

    return super.close();
  }

  Future<void> connectToObd() async {
    if (_obdSocket != null) {
      return;
    }

    try {
      final socket = await Socket.connect(
        Config.host,
        Config.port,
        timeout: _obdConnectionTimeout,
      );

      _obdSocket = socket;

      updateConnectionStatus(true);
      _resetObdState();

      socket.listen(
        _onObdData,
        onError: (error) {
          emit(state.copyWith(stateDashboard: ViewState.error));
          disconnectFromObd();
        },
        onDone: () {
          _obdSocket = null;
          _resetObdState();
          updateConnectionStatus(false);
        },
        cancelOnError: true,
      );

      emit(state.copyWith(stateDashboard: ViewState.initial));
      _sendNextObdCommand();
    } catch (e) {
      _obdSocket = null;
      emit(state.copyWith(stateDashboard: ViewState.error));
      updateConnectionStatus(false);
    }
  }

  void disconnectFromObd() {
    _obdResponseTimeoutTimer?.cancel();
    _obdResponseTimeoutTimer = null;

    _obdSocket?.destroy();
    _obdSocket = null;

    _resetObdState();

    updateConnectionStatus(false);
  }

  void _resetObdState() {
    _obdBuffer = '';
    _obdCommandIndex = 0;
    _waitingForResponse = false;

    _obdResponseTimeoutTimer?.cancel();
    _obdResponseTimeoutTimer = null;
  }

  void _sendNextObdCommand() {
    final socket = _obdSocket;

    if (socket == null) {
      return;
    }

    if (_waitingForResponse) {
      return;
    }

    final obdCommand = _obdCommands[_obdCommandIndex];
    _waitingForResponse = true;
    socket.write('${obdCommand.command}\r');

    _startResponseTimeout();
  }

  void _onObdData(List<int> data) {
    final chunk = String.fromCharCodes(data);

    _obdBuffer += chunk;

    _processObdBuffer();
  }

  void _processObdBuffer() {
    while (true) {
      final promptIndex = _obdBuffer.indexOf('>');

      if (promptIndex == -1) {
        return;
      }

      final rawResponse = _obdBuffer.substring(0, promptIndex).trim();
      _obdBuffer = _obdBuffer.substring(promptIndex + 1);

      if (rawResponse.isEmpty) {
        continue;
      }

      final response = _extractObdResponse(rawResponse);

      if (response == null) {
        continue;
      }

      _handleObdResponse(response);
    }
  }

  String? _extractObdResponse(String rawResponse) {
    final lines = rawResponse
        .split(RegExp(r'[\r\n]+'))
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    for (final line in lines) {
      final normalized = line.replaceAll(RegExp(r'\s+'), ' ').trim();

      if (RegExp(r'^41\s+[0-9A-Fa-f]{2}\b').hasMatch(normalized)) {
        return normalized;
      }
    }

    return null;
  }

  void _handleObdResponse(String response) {
    _obdResponseTimeoutTimer?.cancel();
    _obdResponseTimeoutTimer = null;

    final obdCommand = _obdCommands[_obdCommandIndex];
    final value = ObdUtil.translate(response);

    if (value != null) {
      _updateItemValue(obdCommand.index, value.toInt());
    }

    _waitingForResponse = false;

    _moveToNextCommand();
  }

  void _moveToNextCommand() {
    _obdCommandIndex++;

    if (_obdCommandIndex >= _obdCommands.length) {
      _obdCommandIndex = 0;
    }

    Future.delayed(_obdRequestDelay, () {
      if (_obdSocket == null) {
        return;
      }

      _sendNextObdCommand();
    });
  }

  void _startResponseTimeout() {
    _obdResponseTimeoutTimer?.cancel();

    _obdResponseTimeoutTimer = Timer(_obdResponseTimeout, () {
      if (!_waitingForResponse) {
        return;
      }
      _waitingForResponse = false;

      _moveToNextCommand();
    });
  }

  void updateConnectionStatus(bool isConnected) {
    emit(state.copyWith(isConnected: isConnected));
  }

  void _updateItemValue(int index, int value) {
    final updatedValues = List<int>.from(state.itemValues);

    updatedValues[index] = value;

    emit(state.copyWith(itemValues: updatedValues));
  }
}

class _ObdCommand {
  final String command;
  final int index;
  final String name;

  const _ObdCommand({
    required this.command,
    required this.index,
    required this.name,
  });
}
