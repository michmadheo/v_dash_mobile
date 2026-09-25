import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_dash_mobile/app/assets/colors/asset_colors.dart';
import 'package:v_dash_mobile/app/themes/border/theme_border.dart';
import 'package:v_dash_mobile/app/themes/fonts/theme_fonts.dart';
import 'package:v_dash_mobile/app/themes/margin/theme_margin.dart';
import 'package:v_dash_mobile/app/themes/padding/theme_padding.dart';
import 'package:v_dash_mobile/app/widgets/atoms/gap/gap.dart';
import 'package:v_dash_mobile/app/widgets/atoms/text/text_base.dart';
import 'package:v_dash_mobile/core/dependencies/injection.dart';
import 'package:v_dash_mobile/core/general_helpers/extensions/dynamic_size_extension.dart';
import 'package:v_dash_mobile/features/dashboard/cubit/main/dashboard_cubit.dart';
import 'package:v_dash_mobile/features/dashboard/repository/dashboard_repository.dart';

// Main Screen
part 'screen/dashboard_screen.dart';

// Sections
part 'section/app_bar_section.dart';
part 'section/body_section.dart';

// Widget
part 'widget/dashboard_metric_card.dart';
part 'widget/connection_indicator.dart';

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
