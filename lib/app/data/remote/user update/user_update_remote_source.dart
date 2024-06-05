import 'model/remote_user_update_response.dart';
import 'model/user_update_params.dart';

abstract class UserUpdateRemoteSource {
  Future<RemoteUserUpdateResponse> userUpdate(UserUpdateParams params);
}
