import 'package:flutter_assessment/app/data/remote/user%20update/model/remote_user_update_response.dart';
import 'package:flutter_assessment/app/data/remote/user%20update/model/user_update_params.dart';
import 'package:flutter_assessment/app/data/remote/user%20update/user_update_remote_source.dart';

import 'user_update_repository.dart';

class UserUpdateRepositoryImpl implements UserUpdateRepository {
  final UserUpdateRemoteSource remoteSource;

  UserUpdateRepositoryImpl({
    required this.remoteSource,
  });

  @override
  Future<RemoteUserUpdateResponse> userUpdate(UserUpdateParams params) async {
    try {
      return await remoteSource.userUpdate(params);
    } catch (error) {
      rethrow;
    }
  }
}
