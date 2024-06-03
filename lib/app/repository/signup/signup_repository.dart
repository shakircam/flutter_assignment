import 'package:flutter_assessment/app/data/remote/signup/model/remote_signup_response.dart';
import 'package:flutter_assessment/app/data/remote/signup/model/user_signup_params.dart';

abstract class SignupRepository {
  Future<RemoteSignupResponse> userSignup(UserSignupParams params);
}
