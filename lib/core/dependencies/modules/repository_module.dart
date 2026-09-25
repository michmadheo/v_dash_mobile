import 'package:v_dash_mobile/core/data/remote/demo_data/demo_data.dart';
import 'package:v_dash_mobile/core/dependencies/injection.dart';
import 'package:v_dash_mobile/features/demo_feature/repository/demo_feature_repository.dart';
// @mason-import-anchor <-- Do not remove

void repositoryModule() {
  getIt.registerLazySingleton<DemoFeatureRepository>(
    () => DemoFeatureRepositoryImpl(demoData: getIt<DemoData>()),
  );
	// @mason-anchor <-- Do not remove
}
