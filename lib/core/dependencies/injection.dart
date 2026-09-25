import 'package:v_dash_mobile/core/dependencies/modules/local_data_module.dart';
import 'package:v_dash_mobile/core/dependencies/modules/remote_data_module.dart';
import 'package:v_dash_mobile/core/dependencies/modules/repository_module.dart';
import 'package:v_dash_mobile/core/dependencies/modules/service_module.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class Injection {
  Future<void> initializeDependencyInjection() async {
    localDataModule();
    remoteDataModule();
    repositoryModule();
    serviceModule();
  }
}
