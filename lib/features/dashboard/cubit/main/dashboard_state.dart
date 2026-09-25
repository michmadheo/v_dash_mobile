part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final ViewState stateDashboard;
  final bool isConnected;
  final List<int> itemValues;
  final List<int> itemMaxValues;

  const DashboardState({
    required this.stateDashboard,
    required this.isConnected,
    required this.itemValues,
    required this.itemMaxValues,
  });

  factory DashboardState.initial() =>
    DashboardState(
      stateDashboard: ViewState.initial,
      isConnected: false,
      itemValues: [0, 0, 0, 0, 0, 0],
      itemMaxValues: [100, 100, 100, 100, 100, 100],
    );

  DashboardState copyWith({
    ViewState? stateDashboard,
    bool? isSimulating,
    bool? isConnected,
    List<int>? itemValues,
    List<int>? itemMaxValues,
  }) {
    return DashboardState(
      stateDashboard: stateDashboard ?? this.stateDashboard,
      isConnected: isConnected ?? this.isConnected,
      itemValues: itemValues ?? this.itemValues,
      itemMaxValues: itemMaxValues ?? this.itemMaxValues,
    );
  }

  @override
  List<Object> get props => [
    stateDashboard,
    isConnected,
    itemValues,
    itemMaxValues,
  ];
}
