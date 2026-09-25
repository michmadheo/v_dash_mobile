import 'package:v_dash_mobile/core/data/local/app_status_data/app_status_data.dart';
import 'package:v_dash_mobile/core/dependencies/injection.dart';
import 'package:v_dash_mobile/core/services/local_storage/local_storage.dart';

void localDataModule() {
  getIt.registerLazySingleton<AppStatusData>(
    () => AppStatusData(localStorage: getIt<LocalStorage>()),
  );
}