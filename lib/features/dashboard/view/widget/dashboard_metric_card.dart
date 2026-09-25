part of '../dashboard_view.dart';

/// Symmetric metric box showing an icon, title, value with unit and a progress meter.
class _DashboardMetricCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final num currentValue;
  final String unit;
  final Color color;
  final num maxValue;

  const _DashboardMetricCard({
    required this.icon,
    required this.title,
    required this.currentValue,
    required this.unit,
    required this.color,
    required this.maxValue,
  });

  double get _progress {
    if (maxValue <= 0) return 0;
    return (currentValue / maxValue).clamp(0, 1).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: ThemePadding.paLG,
      decoration: BoxDecoration(
        color: const Color(0xFF141A22),
        borderRadius: ThemeBorder.bc16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18.ds),
              Gap.width(8.ds),
              Expanded(
                child: TextBase(
                  label: title,
                  style: ThemeFonts.captionMedium,
                  color: AssetColors.lightGrey,
                  darkColor: AssetColors.lightGrey,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Gap.height(4.ds),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextBase(
                label: '$currentValue',
                style: ThemeFonts.h2Bold,
                color: AssetColors.white,
                darkColor: AssetColors.white,
              ),
              Gap.width(4.ds),
              Padding(
                padding: ThemePadding.pbXS,
                child: TextBase(
                  label: unit,
                  style: ThemeFonts.captionRegular,
                  color: AssetColors.lightGrey,
                  darkColor: AssetColors.lightGrey,
                ),
              ),
            ],
          ),
          Gap.height(10.ds),
          ClipRRect(
            borderRadius: ThemeBorder.bc8,
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 6.ds,
              backgroundColor: const Color(0xFF262D38),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
