part of '../dashboard_view.dart';

class _BodySection extends StatelessWidget {
  const _BodySection();

  List<_DashboardMetricCard> _metrics(DashboardState state) => [
    _DashboardMetricCard(
      icon: Icons.speed,
      title: 'Speed',
      currentValue: state.itemValues[0],
      unit: 'km/h',
      color: const Color(0xFF2ED47A),
      maxValue: state.itemMaxValues[0],
    ),
    _DashboardMetricCard(
      icon: Icons.av_timer,
      title: 'RPM',
      currentValue: state.itemValues[1],
      unit: 'rpm',
      color: const Color(0xFFFF7A45),
      maxValue: state.itemMaxValues[1],
    ),
    _DashboardMetricCard(
      icon: Icons.thermostat,
      title: 'Coolant Temp',
      currentValue: state.itemValues[2],
      unit: '°C',
      color: const Color(0xFF29B6F6),
      maxValue: state.itemMaxValues[2],
    ),
    _DashboardMetricCard(
      icon: Icons.tune,
      title: 'Throttle',
      currentValue: state.itemValues[3],
      unit: '%',
      color: const Color(0xFF7C4DFF),
      maxValue: state.itemMaxValues[3],
    ),
    _DashboardMetricCard(
      icon: Icons.build,
      title: 'Engine Load',
      currentValue: state.itemValues[4],
      unit: '%',
      color: const Color(0xFF22D3EE),
      maxValue: state.itemMaxValues[4],
    ),
    _DashboardMetricCard(
      icon: Icons.bolt,
      title: 'Voltage',
      currentValue: state.itemValues[5],
      unit: 'V',
      color: const Color(0xFFE0B84C),
      maxValue: state.itemMaxValues[5],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Padding(
          padding: ThemePadding.paLG,
          child: GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: ThemeMargin.mvMD.vertical,
            crossAxisSpacing: ThemeMargin.mhMD.horizontal,
            childAspectRatio: 1.4,
            children: _metrics(state),
          ),
        );
      },
    );
  }
}

