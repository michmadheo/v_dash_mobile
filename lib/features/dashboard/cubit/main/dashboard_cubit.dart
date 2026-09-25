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

  @override // Cancel any ongoing operations when the Cubit is closed
  Future<void> close() {
    _cancelToken.cancel();
    return super.close();
  }

  void exampleChangeState() async {
    emit(state.copyWith(stateDashboard: ViewState.loading));
  }

  void exampleFetchApi() async {
    emit(state.copyWith(stateDashboard: ViewState.loading));
    final result = await repository.getDemoData(cancelToken: _cancelToken);
    if (isClosed) return; // Stop further processing if the Cubit is closed (Especially after api cancel via _cancelToken)
    result.match(
      (failure){
        emit(state.copyWith(
          stateDashboard: ViewState.error
        ));
      },
      (success){
        emit(state.copyWith(
          stateDashboard: ViewState.success,
        ));
      }
    );
  }
}
