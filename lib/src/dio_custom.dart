import 'package:dio/native_imp.dart';
import 'package:softbuilder_dio/src/local_storage.dart';

import 'dio_interceptor.dart';

class DioCustom extends DioForNative {
  final String baseUrl;

  DioCustom({required this.baseUrl}) : super() {
    options.baseUrl = baseUrl;
    interceptors.add(CustomDioInterceptor(LocalStorage()));
  }
}
