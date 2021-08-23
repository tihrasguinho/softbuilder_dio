import 'package:dio/native_imp.dart';
import 'package:softbuilder_dio/src/local_storage.dart';

import 'custom_dio_interceptor.dart';

class CustomDio extends DioForNative {
  final String baseUrl;
  final LocalStorage localStorage;

  CustomDio({required this.baseUrl, required this.localStorage}) : super() {
    options.baseUrl = baseUrl;
    interceptors.add(CustomDioInterceptor(localStorage));
  }
}
