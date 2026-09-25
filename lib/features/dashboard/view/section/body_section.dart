part of '../dashboard_view.dart';

class _BodySection extends StatelessWidget {
  const _BodySection();

  // Sample vehicle metrics, replace with real data from DashboardState later
  static const List<_DashboardMetricCard> _metrics = [
    _DashboardMetricCard(
      icon: Icons.speed,
      title: 'Speed',
      currentValue: 68,
      unit: 'km/h',
      color: Color(0xFF2ED47A),
      maxValue: 220,
    ),
    _DashboardMetricCard(
      icon: Icons.av_timer,
      title: 'RPM',
      currentValue: 2.4,
      unit: 'x1000',
      color: Color(0xFFFF7A45),
      maxValue: 8,
    ),
    _DashboardMetricCard(
      icon: Icons.thermostat,
      title: 'Coolant Temp',
      currentValue: 86,
      unit: '°C',
      color: Color(0xFF29B6F6),
      maxValue: 120,
    ),
    _DashboardMetricCard(
      icon: Icons.local_gas_station,
      title: 'Fuel Level',
      currentValue: 62,
      unit: '%',
      color: Color(0xFF2ED47A),
      maxValue: 100,
    ),
    _DashboardMetricCard(
      icon: Icons.build,
      title: 'Engine Load',
      currentValue: 32,
      unit: '%',
      color: Color(0xFF7C4DFF),
      maxValue: 100,
    ),
    _DashboardMetricCard(
      icon: Icons.near_me,
      title: 'Trip Distance',
      currentValue: 12.8,
      unit: 'km',
      color: Color(0xFF4FC3F7),
      maxValue: 999,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ThemePadding.paLG,
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: ThemeMargin.mvMD.vertical,
        crossAxisSpacing: ThemeMargin.mhMD.horizontal,
        childAspectRatio: 1.4,
        children: _metrics,
      ),
    );
  }
}
