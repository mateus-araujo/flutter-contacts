abstract class IHttpService {
  Future get(String path, {Map<String, dynamic>? queryParameters});
  Future post(String path, {dynamic data});
  Future put(String path, {dynamic data});
  Future delete(String path, {dynamic data});
}
