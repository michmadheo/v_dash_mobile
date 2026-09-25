import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_dash_mobile/app/assets/colors/asset_colors.dart';
import 'package:v_dash_mobile/core/common/view_state/view_state.dart';
import 'package:v_dash_mobile/core/dependencies/injection.dart';
import 'package:v_dash_mobile/features/demo_feature/cubit/demo_feature_cubit.dart';
import 'package:v_dash_mobile/features/demo_feature/repository/demo_feature_repository.dart';
import 'package:v_dash_mobile/app/navigation/object/demo_navigation_object.dart';
import 'package:v_dash_mobile/app/themes/padding/theme_padding.dart';
import 'package:v_dash_mobile/app/widgets/atoms/text/text_base.dart';
import 'package:v_dash_mobile/app/widgets/organisms/status_controller_widget.dart';

// Screen
part 'screen/demo_feature_screen.dart';

class DemoFeatureView extends StatelessWidget {
  final DemoNavigationObject? extra;

  const DemoFeatureView({super.key, this.extra});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DemoFeatureCubit(repository: getIt<DemoFeatureRepository>())
            ..demoCubitApiFunction(),
      child: DemoFeatureScreen(),
    );
  }
}
