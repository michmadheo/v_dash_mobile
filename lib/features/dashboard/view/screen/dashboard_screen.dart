part of '../dashboard_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DashboardCubit, DashboardState>(listener: (context, state) {}),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFF0B0E13),
        // Sample vehicle status, replace with real data from DashboardState later
        appBar: const _AppBarSection(
          vehicleName: 'Toyota Yaris Hatchback',
          isConnected: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: const [_BodySection()]),
        ),
      ),
    );
  }
}
