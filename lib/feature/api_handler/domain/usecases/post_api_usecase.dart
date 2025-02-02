import 'package:api_handler/core/usecase/usecase.dart';
import 'package:api_handler/feature/api_handler/data/datasource/api_remote_datasource.dart';
import 'package:dio/dio.dart';

import '../../../../core/models/api_data/api_data.dart';
import '../../data/models/response_model.dart';

class PostApi implements UseCase<PostApiData> {
  final Dio dio;

  PostApi(this.dio);

  /// calls the Post API with data provided in [GetApiData].
  @override
  Future<ResponseModel> call(PostApiData apiData) async {
    ApiRemoteDataSourceImpl remoteDataSourceImpl = ApiRemoteDataSourceImpl(dio);

    ResponseModel response = await remoteDataSourceImpl.httpPost(
      apiData.url,
      apiData.queries,
      apiData.pathVars,
      apiData.body,
      apiData.headerEnum,
      apiData.responseEnum,
    );

    return response;
  }
}
