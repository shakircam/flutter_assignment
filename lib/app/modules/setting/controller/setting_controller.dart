import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/core/services/service_locator.dart';
import 'package:flutter_assessment/app/data/remote/user%20update/model/remote_user_update_response.dart';
import 'package:flutter_assessment/app/data/remote/user%20update/model/user_update_params.dart';
import 'package:flutter_assessment/app/data/repository/user%20update/user_update_repository.dart';

class SettingController extends ChangeNotifier {
  final UserUpdateRepository _userUpdateRepository =
      serviceLocator<UserUpdateRepository>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<RemoteUserUpdateResponse> userSignup(UserUpdateParams params) async {
    try {
      _isLoading = true;
      notifyListeners();

      RemoteUserUpdateResponse value =
          await _userUpdateRepository.userUpdate(params);

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
