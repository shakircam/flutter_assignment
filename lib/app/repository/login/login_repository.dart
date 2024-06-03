import 'package:flutter_assessment/app/data/remote/login/model/remote_login_response.dart';
import 'package:flutter_assessment/app/data/remote/login/model/user_login_params.dart';

abstract class LoginRepository {
  Future<RemoteLoginResponse> userLogin(UserLoginParams params);
}
