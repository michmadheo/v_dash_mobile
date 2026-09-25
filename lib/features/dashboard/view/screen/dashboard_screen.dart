part of '../dashboard_view.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DashboardCubit, DashboardState>(
          listener: (context, state) {
            if (state.stateDashboard == ViewState.loading) {
            } else if (state.stateDashboard == ViewState.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AssetColors.green,
                  content: TextBase(
                    label: 'Berhasil terhubung dengan OBD',
                    textAlign: TextAlign.center,
                    style: ThemeFonts.captionRegular,
                    color: AssetColors.white,
                  ),
                  behavior: SnackBarBehavior.floating,
                  width: 200.ds,
                  duration: const Duration(seconds: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.ds),
                  ),
                ),
              );
            } else if (state.stateDashboard == ViewState.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AssetColors.red,
                  content: TextBase(
                    label: 'Gagal terhubung dengan OBD',
                    textAlign: TextAlign.center,
                    style: ThemeFonts.captionRegular,
                    color: AssetColors.white,
                  ),
                  behavior: SnackBarBehavior.floating,
                  width: 200.ds,
                  duration: const Duration(seconds: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.ds),
                  ),
                ),
              );
            }
          },
        ),
      ],
      child: BlocSelector<DashboardCubit, DashboardState, bool>(
        selector: (state) {
          return state.isConnected;
        },
        builder: (context, isConnected) {
          return Scaffold(
            backgroundColor: AssetColors.lightBlack,
            appBar: _AppBarSection(
              vehicleName: 'Car Dashboard',
              isConnected: isConnected,
            ),
            body: SingleChildScrollView(
              child: Column(children: const [_BodySection()]),
            ),
          );
        },
      ),
    );
  }
}
