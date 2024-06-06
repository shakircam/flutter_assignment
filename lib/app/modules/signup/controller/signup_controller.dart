import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/core/services/service_locator.dart';
import 'package:flutter_assessment/app/data/remote/signup/model/remote_signup_response.dart';
import 'package:flutter_assessment/app/data/remote/signup/model/user_signup_params.dart';
import 'package:flutter_assessment/app/data/repository/signup/signup_repository.dart';

class SignupController extends ChangeNotifier {
  final SignupRepository _signupRepository = serviceLocator<SignupRepository>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<RemoteSignupResponse> userSignup(UserSignupParams params) async {
    try {
      _isLoading = true;
      notifyListeners();

      RemoteSignupResponse value = await _signupRepository.userSignup(params);

      _isLoading = false;
      notifyListeners();

      return value; // Return the response
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception("Signup failed: $e");
    }
  }
}
