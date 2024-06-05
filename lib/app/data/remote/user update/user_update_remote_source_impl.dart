import 'package:flutter_assessment/app/core/base/base_remote_source.dart';
import 'package:flutter_assessment/app/core/values/api_end_points.dart';
import 'package:dio/dio.dart';
import 'model/remote_user_update_response.dart';
import 'model/user_update_params.dart';
import 'user_update_remote_source.dart';

class UserUpdateRemoteSourceImpl extends BaseRemoteSource
    implements UserUpdateRemoteSource {
  @override
  Future<RemoteUserUpdateResponse> userUpdate(UserUpdateParams params) async {
    String endpoint = ApiEndPoints.userUpdateEndPoint;
    var dioCall = dioClient.post(endpoint, queryParameters: params.toJson());

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseRemoteUserUpdateResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  RemoteUserUpdateResponse _parseRemoteUserUpdateResponse(
      Response<dynamic> response) {
    return RemoteUserUpdateResponse.fromJson(response.data);
  }
}
