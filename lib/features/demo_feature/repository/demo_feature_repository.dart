import 'package:dio/dio.dart';
import 'package:v_dash_mobile/core/common/type_def/api_result_type_def.dart';
import 'package:v_dash_mobile/core/data/remote/demo_data/demo_data.dart';
import 'package:v_dash_mobile/core/data/remote/demo_data/dto/demo_data_response.dart';
import 'package:fpdart/fpdart.dart';

abstract class DemoFeatureRepository {
  ApiResult<DemoDataResponse> getDemoData({CancelToken? cancelToken});
}

class DemoFeatureRepositoryImpl implements DemoFeatureRepository {
  final DemoData demoData;

  DemoFeatureRepositoryImpl({required this.demoData});
  
  @override
  ApiResult<DemoDataResponse> getDemoData({CancelToken? cancelToken}) async {
    final result = await demoData.fetchDemoData(cancelToken: cancelToken);
    return result.match(
      (failure) => Either.left(failure),
      (success) => Either.right(success),
    );
  }
}