import 'package:contacts/domain/services/http_service.dart';
import 'package:dio/dio.dart';

class HttpService implements IHttpService {
  final Dio _service;

  HttpService(this._service);

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    final response = await _service.get(path, queryParameters: queryParameters);

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
