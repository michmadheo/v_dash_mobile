import 'package:v_dash_mobile/core/dependencies/injection.dart';
import 'package:v_dash_mobile/core/services/api_fetch/api_fetch.dart';
import 'package:v_dash_mobile/core/services/local_storage/local_storage.dart';

void serviceModule() {
  getIt.registerLazySingleton<ApiFetch>(() => ApiFetch());
  getIt.registerLazySingleton<LocalStorage>(() => LocalStorage());
}