part of '../dashboard_view.dart';

/// Dot + label showing live connection status: green/"Connected" or red/"Not Connected".
class _ConnectionIndicator extends StatelessWidget {
  final bool isConnected;

  const _ConnectionIndicator({required this.isConnected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.ds,
          height: 8.ds,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isConnected ? AssetColors.green : AssetColors.red,
          ),
        ),
        Gap.width(6.ds),
        TextBase(
          label: isConnected ? 'Connected' : 'Not Connected',
          style: ThemeFonts.captionRegular,
          color: isConnected ? AssetColors.green : AssetColors.red,
          darkColor: isConnected ? AssetColors.green : AssetColors.red,
        ),
      ],
    );
  }
}
