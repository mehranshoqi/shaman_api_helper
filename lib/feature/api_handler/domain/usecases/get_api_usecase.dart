import 'package:api_handler/core/usecase/usecase.dart';
import 'package:api_handler/feature/api_handler/data/datasource/api_remote_datasource.dart';
import 'package:dio/dio.dart';

import '../../../../core/models/api_data/api_data.dart';
import '../../data/models/response_model.dart';

class GetApi implements UseCase<GetApiData> {
  final Dio dio;

  GetApi(this.dio);

  /// calls the 'Get' API with data provided in `GetApiData`.
  @override
  Future<ResponseModel> call(GetApiData apiData) async {
    ApiRemoteDataSourceImpl remoteDataSourceImpl = ApiRemoteDataSourceImpl(dio);

    ResponseModel response = await remoteDataSourceImpl.httpGet(
      apiData.url,
      apiData.queries,
      apiData.pathVars,
      apiData.headerEnum,
      apiData.responseEnum,
    );

    return response;
  }
}
