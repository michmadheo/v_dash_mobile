import 'package:dio/dio.dart';
import 'package:v_dash_mobile/core/common/type_def/api_result_type_def.dart';
import 'package:v_dash_mobile/core/common/base/base_failure_response.dart';
import 'package:v_dash_mobile/core/config/config.dart';
import 'package:v_dash_mobile/core/data/remote/demo_data/dto/demo_data_response.dart';
import 'package:v_dash_mobile/core/data/remote/api_path.dart';
import 'package:v_dash_mobile/core/services/api_fetch/api_fetch.dart';
import 'package:fpdart/fpdart.dart';

class DemoData {
  final ApiFetch apiFetch;

  DemoData({required this.apiFetch});

  ApiResult<DemoDataResponse> fetchDemoData({CancelToken? cancelToken}) async {
    try {
      final data = await apiFetch.getApi(
        url: '${Config.demoDomain}${ApiPath.demoEndpoint}',
        cancelToken: cancelToken,
      );
      DemoDataResponse response = DemoDataResponse.fromJson(data);
      return Right(response);
    } catch (e) {
      return Left(BaseFailureResponse(message: 'Failed to fetch demo data'));
    }
  }
}
