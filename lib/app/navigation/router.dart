// import 'package:flutter/material.dart'; // Uncomment this if you want to use StatefullShellRouter
import 'package:v_dash_mobile/core/config/config.dart';
import 'package:v_dash_mobile/features/demo_feature/view/demo_feature_view.dart';
// import 'package:v_dash_mobile/navigation/animation/navigation_animation.dart'; // Uncomment this if you want to use custom animations when navigating to the DemoFeatureView
import 'package:v_dash_mobile/app/navigation/object/demo_navigation_object.dart';
import 'package:v_dash_mobile/app/navigation/observer/navigation_observer.dart';
import 'package:v_dash_mobile/app/navigation/path/navigation_path.dart';
import 'package:v_dash_mobile/features/dashboard/view/dashboard_view.dart';
// @mason-import-anchor <-- Do not remove
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: NavigationPath.dashboard,
  navigatorKey: Config.navigatorKey,
  observers: [NavigationObserver()],
  routes: [
    GoRoute(
      path: NavigationPath.demoFeature,
      builder: (context, state) {
        DemoNavigationObject? extra = state.extra != null
            ? state.extra as DemoNavigationObject
            : null; // This is an example if you want to pass extra data to the page
        return DemoFeatureView(
          extra: extra, // Pass the extra data to the view, don't forget to add this in the view constructor
        );
      },
    ),
    GoRoute(
      path: NavigationPath.dashboard,
      builder: (context, state) {
        return DashboardView();
      },
    ),
    // @mason-anchor <-- Do not remove

    /// If you're planning to use NavigationBar or NavigationRail, you can use StatefulShellRouter below to avoid re-loading the active page when switching tabs.
    // StatefulShellRoute.indexedStack(
    //   builder: (context, state, screen) {
    //     // String path = state.fullPath ?? ''; // This is the path of the active tab
    //     // Widget widget = screen; // This is the main view
    //     return DemoFeatureView(); // This is just a placeholder, This should be the main view of the bottomnavbar or railling. Pass the path and widget here
    //   },
    //   branches: [
    //     /// These are the views of each tab, it should be more than one. you can add more views here
    //     StatefulShellBranch(
    //       routes: [
    //         GoRoute(
    //           path: NavigationPath.initialRoute,
    //           builder: (context, state) {
    //             DemoNavigationObject extra =
    //                 state.extra
    //                     as DemoNavigationObject;
    //             return DemoFeatureView(
    //               extra:
    //                   extra,
    //             );
    //           },
    //         ),
    //       ],
    //     ),
    //     /// Add more StatefulShellBranch here if you want to add more tabs
    //     // StatefulShellBranch(
    //     //   routes: [
    //     //     GoRoute(
    //     //       path: NavigationPath.initialRoute,
    //     //       builder: (context, state) {
    //     //         return DemoFeatureView(
    //     //           extra:
    //     //               extra,
    //     //         );
    //     //       },
    //     //     ),
    //     //   ],
    //     // ),
    //   ],
    // ),
  ],
);
