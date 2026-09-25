part of '../dashboard_view.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DashboardCubit, DashboardState>(
          listener: (context, state) {},
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
