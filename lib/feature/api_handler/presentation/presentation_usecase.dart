import 'package:api_handler/core/consts/language.dart';
import 'package:api_handler/core/consts/user_agent.dart';
import 'package:api_handler/feature/api_handler/domain/usecases/get_api_usecase.dart';
import 'package:api_handler/main.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../core/models/api_data/api_data.dart';
import '../../../core/token/token.dart';
import '../data/enums/header_enum.dart';
import '../data/enums/response_enum.dart';
import '../data/models/query_model.dart';
import '../data/models/response_model.dart';
import '../domain/usecases/delete_api_usecase.dart';
import '../domain/usecases/post_api_usecase.dart';
import '../domain/usecases/put_api_usecase.dart';

class APIHandler {
  final Dio dio = Dio();

  late GetApi _getApi;
  late PostApi _postApi;
  late PutApi _putApi;
  late DeleteApi _deleteApi;

  APIHandler(String deviceId) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        request: true,
        error: true,
        compact: false,
        maxWidth: 300,
      ),
    );
    // dio.options.headers['X-Device-ID'] = deviceId;

    _getApi = GetApi(dio);
    _postApi = PostApi(dio);
    _putApi = PutApi(dio);
    _deleteApi = DeleteApi(dio);
  }

  static Function? _onTokenExpired;

  /// this method is called when the token is expired.
  onTokenExpired(Function onTokenExp) {
    _onTokenExpired = onTokenExp;
  }

  /// sets Token to use bearer header in APIs.
  setToken(String? rToken) {
    Token token = Token();

    token.setToken = rToken;
  }

  setUserAgent(String agent) {
    UserAgent userAgent = UserAgent();

    userAgent.setAgent = agent;
  }

  setLanguage(String lang) {
    Language language = Language();

    language.setLanguage = lang;
  }

  /// get Token if exists
  // String? get token => Token().token;

  /// calls a 'Get' API and returns a `ResponseModel`.
  Future<ResponseModel> get(
    String url, {
    List<QueryModel>? queries,
    String? pathVariable,
    required HeaderEnum headerEnum,
    required ResponseEnum responseEnum,
  }) async {
    ResponseModel responseModel = await _getApi(GetApiData(
      url,
      queries: queries,
      pathVars: pathVariable,
      headerEnum: headerEnum,
      responseEnum: responseEnum,
    ));
    if (_onTokenExpired != null && responseModel.statusCode == 401) {
      _onTokenExpired!();
    }
    return responseModel;
  }

  /// calls a 'Post' API and returns a `ResponseModel`.
  Future<ResponseModel> post(
    String url, {
    List<QueryModel>? queries,
    String? pathVariable,
    dynamic body,
    required HeaderEnum headerEnum,
    required ResponseEnum responseEnum,
  }) async {
    ResponseModel responseModel = await _postApi(PostApiData(
      url,
      queries: queries,
      pathVars: pathVariable,
      body: body,
      headerEnum: headerEnum,
      responseEnum: responseEnum,
    ));
    if (_onTokenExpired != null && responseModel.statusCode == 401) {
      _onTokenExpired!();
    }
    return responseModel;
  }

  /// calls a 'put' API and returns a `ResponseModel`.
  Future<ResponseModel> put(
    String url, {
    List<QueryModel>? queries,
    String? pathVariable,
    dynamic body,
    required HeaderEnum headerEnum,
    required ResponseEnum responseEnum,
  }) async {
    ResponseModel responseModel = await _putApi(PutApiData(
      url,
      queries: queries,
      pathVars: pathVariable,
      body: body,
      headerEnum: headerEnum,
      responseEnum: responseEnum,
    ));
    if (_onTokenExpired != null && responseModel.statusCode == 401) {
      _onTokenExpired!();
    }
    return responseModel;
  }

  /// calls a 'delete' API and returns a `ResponseModel`.
  Future<ResponseModel> delete(
    String url, {
    List<QueryModel>? queries,
    String? pathVariable,
    dynamic body,
    required HeaderEnum headerEnum,
    required ResponseEnum responseEnum,
  }) async {
    ResponseModel responseModel = await _deleteApi(DeleteApiData(
      url,
      queries: queries,
      pathVars: pathVariable,
      body: body,
      headerEnum: headerEnum,
      responseEnum: responseEnum,
    ));
    if (_onTokenExpired != null && responseModel.statusCode == 401) {
      _onTokenExpired!();
    }
    return responseModel;
  }
}
