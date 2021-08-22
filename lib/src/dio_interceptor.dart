import 'package:dio/dio.dart';
import 'package:softbuilder_dio/src/local_storage.dart';

class CustomDioInterceptor extends InterceptorsWrapper {
  final LocalStorage _storage;

  CustomDioInterceptor(this._storage);

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    _setTokenOnHeaders(options);
    return super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) {
    return super.onError(err, handler);
  }

  _setTokenOnHeaders(RequestOptions options) async {
    final token = await _storage.get('token');
    options.headers['authorization'] = 'Bearer $token';
    print("Request [${options.path}]");
  }
}
