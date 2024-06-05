import 'package:flutter_assessment/app/core/base/base_remote_source.dart';
import 'package:flutter_assessment/app/core/values/api_end_points.dart';
import 'package:dio/dio.dart';
import 'model/remote_signup_response.dart';
import 'model/user_signup_params.dart';
import 'signup_remote_source.dart';

class SignupRemoteSourceImpl extends BaseRemoteSource
    implements SignupRemoteSource {
  @override
  Future<RemoteSignupResponse> userSignup(UserSignupParams params) async {
    String endpoint = ApiEndPoints.signupEndPoint;
    var dioCall = dioClient.post(endpoint, queryParameters: params.toJson());

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseRemoteSignupResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  RemoteSignupResponse _parseRemoteSignupResponse(Response<dynamic> response) {
    return RemoteSignupResponse.fromJson(response.data);
  }
}
