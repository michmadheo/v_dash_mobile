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
    return ClipRRect(
      borderRadius: ThemeBorder.bc16,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 16,
          sigmaY: 16,
        ),
        child: Container(
          width: double.infinity,
          padding: ThemePadding.paLG,
          decoration: BoxDecoration(
            // Glass surface
            color: const Color(0xFF141A22).withValues(alpha: 0.72),

            borderRadius: ThemeBorder.bc16,

            // Glass edge
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.10),
              width: 1,
            ),

            // Subtle depth
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.20),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: color,
                    size: 18.ds,
                  ),
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
                // Eases towards the new value instead of jumping instantly
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: _progress),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  builder: (context, animatedValue, child) {
                    return LinearProgressIndicator(
                      value: animatedValue,
                      minHeight: 6.ds,
                      backgroundColor: Colors.white.withValues(alpha: 0.08),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}