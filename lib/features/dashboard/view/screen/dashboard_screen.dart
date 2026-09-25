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
              vehicleName: 'Toyota Yaris Hatchback',
              isConnected: isConnected,
            ),
            body: SingleChildScrollView(
              child: Column(children: const [_BodySection()]),
            ),
            // floatingActionButton: FloatingActionButton(
            //   backgroundColor: AssetColors.red,
            //   onPressed: () => dashboardCubit.toggleSimulation(),
            //   child: BlocBuilder<DashboardCubit, DashboardState>(
            //     buildWhen: (previous, current) =>
            //         previous.isSimulating != current.isSimulating,
            //     builder: (context, state) {
            //       return Icon(state.isSimulating ? Icons.stop : Icons.play_arrow);
            //     },
            //   ),
            // ),
          );
        },
      ),
    );
  }
}
