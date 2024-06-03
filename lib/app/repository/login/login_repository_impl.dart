import 'package:flutter_assessment/app/core/services/service_locator.dart';
import 'package:flutter_assessment/app/data/remote/login/login_remote_source.dart';
import 'package:flutter_assessment/app/data/remote/login/model/user_login_params.dart';
import '../../remote/login/model/remote_login_response.dart';
import 'login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteSource remoteSource;

  LoginRepositoryImpl({
    required this.remoteSource,
  });

  @override
  Future<RemoteLoginResponse> userLogin(UserLoginParams params) async {
    try {
      return await remoteSource.userLogin(params);
    } catch (error) {
      rethrow;
    }
  }
}
