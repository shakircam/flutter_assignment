import 'package:flutter_assessment/app/data/remote/signup/model/remote_signup_response.dart';
import 'package:flutter_assessment/app/data/remote/signup/model/user_signup_params.dart';
import 'package:flutter_assessment/app/data/remote/signup/signup_remote_source.dart';

import 'signup_repository.dart';

class SignupRepositoryImpl implements SignupRepository {
  final SignupRemoteSource remoteSource;

  SignupRepositoryImpl({
    required this.remoteSource,
  });

  @override
  Future<RemoteSignupResponse> userSignup(UserSignupParams params) async {
    try {
      return await remoteSource.userSignup(params);
    } catch (error) {
      rethrow;
    }
  }
}
