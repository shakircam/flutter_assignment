import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_assessment/app/core/services/service_locator.dart';
import 'package:flutter_assessment/app/data/local/preference/pref_manager.dart';
import 'package:flutter_assessment/app/utils/constants.dart';

class RequestHeaderInterceptor extends InterceptorsWrapper {
  final PrefManager _preference = serviceLocator<PrefManager>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    getCustomHeaders().then((customHeaders) {
      options.headers.addAll(customHeaders);
      super.onRequest(options, handler);
    }).catchError((error) {
      handler.reject(DioException(requestOptions: options, error: error));
    });
  }

  Future<Map<String, String>> getCustomHeaders() async {
    var customHeaders = {'Accept': 'application/json'};
    String? token =
        await _preference.getString(APP_TOKEN); // from local preference
    if (token != null) {
      customHeaders.addAll({'Authorization': 'Bearer $token'});
    }
    return customHeaders;
  }
}
