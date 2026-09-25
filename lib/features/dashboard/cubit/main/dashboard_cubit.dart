import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:v_dash_mobile/core/common/view_state/view_state.dart';
import 'package:v_dash_mobile/features/dashboard/repository/dashboard_repository.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {

  final DashboardRepository repository;

  DashboardCubit({
    required this.repository,
  }) : super(DashboardState.initial());

  final CancelToken _cancelToken = CancelToken();
  final Random _random = Random();
  final List<Timer?> _itemSimulationTimers = List<Timer?>.filled(6, null);

  @override // Cancel any ongoing operations when the Cubit is closed
  Future<void> close() {
    _cancelToken.cancel();
    for (final timer in _itemSimulationTimers) {
      timer?.cancel();
    }
    return super.close();
  }

  // Simulates realtime data as if it were being pushed by a live vehicle connection
  void toggleSimulation() {
    if (state.isSimulating) {
      for (final timer in _itemSimulationTimers) {
        timer?.cancel();
      }
      emit(state.copyWith(isSimulating: false));
      return;
    }

    emit(state.copyWith(isSimulating: true));
    // Each item ticks on its own interval so cards don't all update at once
    for (var i = 0; i < _itemSimulationTimers.length; i++) {
      _itemSimulationTimers[i] = Timer.periodic(Duration(seconds: 2 + i), (_) {
        _updateItemValue(i, _random.nextInt(100));
      });
    }
  }

  void _updateItemValue(int index, int value) {
    final updatedValues = List<int>.from(state.itemValues);
    updatedValues[index] = value;
    emit(state.copyWith(itemValues: updatedValues));
  }
}
