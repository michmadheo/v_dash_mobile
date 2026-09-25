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
        appBar: _AppBarSection(),
        body: SingleChildScrollView(
          child: Column(children: const [_BodySection()]),
        ),
      ),
    );
  }
}
