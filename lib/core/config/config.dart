import 'package:flutter/material.dart';
import 'package:v_dash_mobile/core/config/env/env.dart';

class Config {
  const Config._();

  // Navigator Key
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static String demoDomain = 'https://reactnative.dev';

  // Localization
  static List<Locale> supportedLocales = const [
    Locale('en'),
    Locale('fr'),
  ];
  static Locale fallbackLocale = const Locale('en');
  static String localizationPath = 'assets/translations';

  // Environment (Add more if you add more keys in the env.dart file)
  static String flavor = Env.flavor;
  static String host = Env.host;
  static int port = int.parse(Env.port);
}
