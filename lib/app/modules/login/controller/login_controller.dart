import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/core/services/service_locator.dart';
import 'package:flutter_assessment/app/data/local/preference/pref_manager.dart';
import 'package:flutter_assessment/app/data/remote/login/model/remote_login_response.dart';
import 'package:flutter_assessment/app/data/remote/login/model/user_login_params.dart';
import 'package:flutter_assessment/app/data/repository/login/login_repository.dart';
import 'package:flutter_assessment/app/utils/constants.dart';

class LoginController extends ChangeNotifier {
  final LoginRepository _loginRepository = serviceLocator<LoginRepository>();
  final PrefManager _local = serviceLocator<PrefManager>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<RemoteLoginResponse> userLogin(UserLoginParams params) async {
    try {
      _isLoading = true;
      notifyListeners();

      RemoteLoginResponse value = await _loginRepository.userLogin(params);
      if (value.token.isNotEmpty) {
        await _local.setString(APP_TOKEN, value.token);
      }

      _isLoading = false;
      notifyListeners();

      return value; // Return the response
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception("Login failed: $e");
    }
  }
}
