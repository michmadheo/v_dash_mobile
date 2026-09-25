part of '../dashboard_view.dart';

class _AppBarSection extends StatelessWidget implements PreferredSizeWidget {
  final String vehicleName;
  final bool isConnected;

  const _AppBarSection({
    required this.vehicleName,
    required this.isConnected,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0B0E13),
      title: Padding(
        padding: ThemePadding.plMD,
        child: Row(
          children: [
            Icon(Icons.directions_car, color: AssetColors.white, size: 18.ds),
            Gap.width(8.ds),
            TextBase(
              label: vehicleName,
              style: ThemeFonts.captionMedium,
              color: AssetColors.white,
              darkColor: AssetColors.white,
            ),
            Gap.width(8.ds),
            _ConnectionIndicator(isConnected: isConnected),
          ],
        ),
      ),
    );
  }
}
