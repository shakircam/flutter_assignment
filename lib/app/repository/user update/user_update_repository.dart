import 'package:flutter_assessment/app/data/remote/user%20update/model/remote_user_update_response.dart';
import 'package:flutter_assessment/app/data/remote/user%20update/model/user_update_params.dart';

abstract class UserUpdateRepository {
  Future<RemoteUserUpdateResponse> userUpdate(UserUpdateParams params);
}
