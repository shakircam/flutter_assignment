import 'model/remote_login_response.dart';
import 'model/user_login_params.dart';

abstract class LoginRemoteSource {
  Future<RemoteLoginResponse> userLogin(UserLoginParams params);
}
