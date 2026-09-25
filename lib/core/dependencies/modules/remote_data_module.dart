import 'package:v_dash_mobile/core/data/remote/demo_data/demo_data.dart';
import 'package:v_dash_mobile/core/dependencies/injection.dart';
import 'package:v_dash_mobile/core/services/api_fetch/api_fetch.dart';

void remoteDataModule() {
  getIt.registerLazySingleton<DemoData>(
    () => DemoData(apiFetch: getIt<ApiFetch>()),
  );
}
