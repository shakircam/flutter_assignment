import 'package:flutter_assessment/app/core/base/base_remote_source.dart';
import 'package:flutter_assessment/app/core/values/api_end_points.dart';
import 'package:flutter_assessment/app/data/remote/login/login_remote_source.dart';
import 'package:dio/dio.dart';

import 'model/remote_login_response.dart';
import 'model/user_login_params.dart';

class LoginRemoteSourceImpl extends BaseRemoteSource
    implements LoginRemoteSource {
  @override
  Future<RemoteLoginResponse> userLogin(UserLoginParams params) async {
    String endpoint = ApiEndPoints.loginEndPoint;
    var dioCall = dioClient.post(endpoint, queryParameters: params.toJson());

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseRemoteLoginResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  RemoteLoginResponse _parseRemoteLoginResponse(Response<dynamic> response) {
    return RemoteLoginResponse.fromJson(response.data);
  }
}
