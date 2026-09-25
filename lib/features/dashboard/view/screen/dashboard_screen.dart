part of '../dashboard_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final dashboardCubit = context.read<DashboardCubit>();

  @override
  void initState() {
    // startMonitor();
    super.initState();
  }

  void startMonitor() {
    dashboardCubit.toggleSimulation();
  }
  

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DashboardCubit, DashboardState>(listener: (context, state) {}),
      ],
      child: Scaffold(
        backgroundColor: AssetColors.lightBlack,
        appBar: const _AppBarSection(
          vehicleName: 'Toyota Yaris Hatchback',
          isConnected: true,
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
      ),
    );
  }
}
