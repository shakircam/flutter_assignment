import 'model/remote_signup_response.dart';
import 'model/user_signup_params.dart';

abstract class SignupRemoteSource {
  Future<RemoteSignupResponse> userSignup(UserSignupParams params);
}
