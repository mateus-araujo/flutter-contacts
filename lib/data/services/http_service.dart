import 'package:dio/dio.dart';

import 'package:contacts/domain/services/http_service.dart';

class HttpService implements IHttpService {
  late Dio _service;

  HttpService({
    String baseUrl = '',
    String? contentType,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    ResponseType? responseType = ResponseType.json,
  }) {
    _service = Dio(BaseOptions(
      baseUrl: baseUrl,
      contentType: contentType,
      headers: headers,
      queryParameters: queryParameters,
      responseType: responseType,
    ));
  }

  @override
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = await _service.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );

    return response;
  }

  @override
  Future post(String path, {data}) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future put(String path, {data}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  Future delete(String path, {data}) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
