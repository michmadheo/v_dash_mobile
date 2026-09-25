part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final ViewState stateDashboard;
  const DashboardState({
    required this.stateDashboard,
  });

  factory DashboardState.initial() =>
    DashboardState(
      stateDashboard: ViewState.initial
  );

  DashboardState copyWith({
    ViewState? stateDashboard
  }) {
    return DashboardState(stateDashboard: stateDashboard ?? this.stateDashboard);
  }

  @override
  List<Object> get props => [
    stateDashboard
  ];
}
