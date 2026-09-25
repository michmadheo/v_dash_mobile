import 'dart:async';
import 'dart:io';
// import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:v_dash_mobile/core/common/view_state/view_state.dart';
import 'package:v_dash_mobile/core/general_helpers/utils/connection_util.dart';
import 'package:v_dash_mobile/core/general_helpers/utils/obd_util.dart';
import 'package:v_dash_mobile/features/dashboard/repository/dashboard_repository.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository repository;

  DashboardCubit({required this.repository}) : super(DashboardState.initial()) {
    _listenToConnectivity();
  }

  final CancelToken _cancelToken = CancelToken();
  // final Random _random = Random();
  final List<Timer?> _itemSimulationTimers = List<Timer?>.filled(6, null);
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  Socket? _obdSocket;
  Timer? _obdTimer;

  void _listenToConnectivity() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      result,
    ) async {
      final isWifiConnected = result.contains(ConnectivityResult.wifi);


      if (isWifiConnected) {
        String? wifiGateway = await ConnectionUtil.getWifiGateway();
        if (wifiGateway == '10.0.2.2') {
          connectToObd();
        } else {
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

  // void toggleSimulation(bool status) {
  //   if (status == false) {
  //     for (final timer in _itemSimulationTimers) {
  //       timer?.cancel();
  //     }

  //     emit(state.copyWith(isSimulating: false));

  //     return;
  //   }

  //   emit(state.copyWith(isSimulating: true));

  //   for (var i = 0; i < _itemSimulationTimers.length; i++) {
  //     _itemSimulationTimers[i] = Timer.periodic(Duration(seconds: 2 + i), (_) {
  //       _updateItemValue(i, _random.nextInt(100));
  //     });
  //   }
  // }

  Future<void> connectToObd() async {
    if (_obdSocket != null) {
      return;
    }

    try {
      print('Connecting to OBD...');
      updateConnectionStatus(true);
      final socket = await Socket.connect(
        '10.0.2.2',
        35000,
        timeout: const Duration(seconds: 3),
      );

      _obdSocket = socket;

      socket.listen(
        (data) {
          final response = String.fromCharCodes(data).trim();

          if (response.isEmpty) {
            return;
          }

          final value = ObdUtil.translate(response);

          if (value == null) {
            return;
          }

          if (response.contains('41 0D')) {
            // 0 - Speed
            _updateItemValue(0, value.toInt());
          } else if (response.contains('41 0C')) {
            // 1 - RPM
            _updateItemValue(1, value.toInt());
          } else if (response.contains('41 05')) {
            // 2 - Coolant Temperature
            _updateItemValue(2, value.toInt());
          } else if (response.contains('41 11')) {
            // 3 - Throttle
            _updateItemValue(3, value.toInt());
          } else if (response.contains('41 04')) {
            // 4 - Engine Load
            _updateItemValue(4, value.toInt());
          } else if (response.contains('41 42')) {
            // 5 - Voltage
            _updateItemValue(5, value.toInt());
          }
        },
        onError: (error) {
          print('❌ OBD SOCKET ERROR: $error');

          disconnectFromObd();
        },
        onDone: () {
          print('🔌 OBD DISCONNECTED');

          _obdSocket = null;
          _obdTimer?.cancel();
          _obdTimer = null;
        },
      );

      _obdTimer?.cancel();

      final commands = [
        '010D', // 0 - Speed
        '010C', // 1 - RPM
        '0105', // 2 - Coolant
        '0111', // 3 - Throttle
        '0104', // 4 - Engine Load
        '0142', // 5 - Voltage
      ];

      var index = 0;

      _obdTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
        _obdSocket?.write('${commands[index]}\r');

        index++;

        if (index >= commands.length) {
          index = 0;
        }
      });
    } catch (e) {
      print('❌ OBD CONNECTION FAILED: $e');

      _obdSocket = null;
    }
  }

  void disconnectFromObd() {
    _obdTimer?.cancel();
    _obdTimer = null;
    _obdSocket?.destroy();
    _obdSocket = null;
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
