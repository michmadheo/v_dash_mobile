import 'package:v_dash_mobile/core/common/base/base_failure_response.dart';
import 'package:fpdart/fpdart.dart';

typedef ApiResult<T> = Future<Either<BaseFailureResponse, T>>;