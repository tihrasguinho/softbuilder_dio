import 'package:dio/native_imp.dart';
import 'package:softbuilder_dio/src/local_storage.dart';

import 'custom_dio_interceptor.dart';

class CustomDio extends DioForNative {
  final String baseUrl;

  CustomDio({required this.baseUrl}) : super() {
    options.baseUrl = baseUrl;
    interceptors.add(CustomDioInterceptor(LocalStorage()));
  }
}
