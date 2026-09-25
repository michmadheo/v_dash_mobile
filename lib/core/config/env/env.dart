import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'HOST')
  static final String host = _Env.host;
  @EnviedField(varName: 'PORT')
  static final String port = _Env.port;
  @EnviedField(varName: 'FLAVOR')
  static final String flavor = _Env.flavor;
}
