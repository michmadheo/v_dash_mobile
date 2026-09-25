import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_dash_mobile/app/widgets/atoms/text/text_base.dart';
import 'package:v_dash_mobile/core/dependencies/injection.dart';
import 'package:v_dash_mobile/features/dashboard/cubit/main/dashboard_cubit.dart';
import 'package:v_dash_mobile/features/dashboard/repository/dashboard_repository.dart';

// Main Screen
part 'screen/dashboard_screen.dart';

// Sections
part 'section/app_bar_section.dart';
part 'section/body_section.dart';

// Widget
part 'widget/sample_widget.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              DashboardCubit(repository: getIt<DashboardRepository>()),
        ),
      ],
      child: const DashboardScreen(),
    );
  }
}
