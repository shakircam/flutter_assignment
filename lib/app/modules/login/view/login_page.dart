import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/core/route/route_paths.dart';
import 'package:flutter_assessment/app/core/values/app_colors.dart';
import 'package:flutter_assessment/app/core/values/app_icons.dart';
import 'package:flutter_assessment/app/core/widget/button/custom_button.dart';
import 'package:flutter_assessment/app/core/widget/image/asset_image_view.dart';
import 'package:flutter_assessment/app/core/widget/input%20field/custom_text_field.dart';
import 'package:flutter_assessment/app/data/remote/login/model/user_login_params.dart';
import 'package:flutter_assessment/app/modules/login/controller/login_controller.dart';
import 'package:flutter_assessment/app/utils/snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Logo
                AssetImageView(
                  fileName: AppIcons.appLogoIcon,
                  height: 40.h,
                ),
                const SizedBox(height: 40.0),
                const Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.almostBlack),
                ),
                const SizedBox(height: 20.0),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            controller: _userNameController,
                            prefixIcon: const Icon(
                              Icons.verified_user,
                              color: AppColors.neutralGray,
                            ),
                            hintText: 'User name',
                            fieldType: InputFieldType.text),
                        const SizedBox(height: 20.0),
                        CustomTextField(
                            controller: _passwordController,
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: AppColors.neutralGray,
                            ),
                            hintText: 'Password',
                            fieldType: InputFieldType.password),
                        const SizedBox(height: 10.0),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 50.0),
                        // Login Button
                        Consumer<LoginController>(
                            builder: (context, loginController, _) {
                          return CustomButton(
                            onPressed: _submit,
                            text: 'Login',
                            buttonColor: AppColors.checkboxColor,
                            textColor: Colors.white,
                            borderRadius: 8,
                            isLoading: loginController.isLoading,
                          );
                        }),
                      ],
                    )),

                const SizedBox(height: 20.0),
                // Social Media Buttons
                AssetImageView(
                  fileName: AppIcons.socialIcon,
                  height: 50.h,
                ),
                const SizedBox(height: 20.0),
                // Create New Account
                GestureDetector(
                  onTap: () {
                    context.go(RoutePaths.signupPage);
                  },
                  child: const Text(
                    'Create New Account',
                    style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with your logic
      log('Form is valid');
      UserLoginParams params = UserLoginParams(
          username: _userNameController.text,
          password: _passwordController.text);
      Provider.of<LoginController>(context, listen: false)
          .userLogin(params)
          .then((value) {
        if (value.token.isNotEmpty) {
          context.go(RoutePaths.mainPage);
        }
      }).catchError((error) {
        context.showSnackbar('An error occurred: $error');
      });
    } else {
      // Form is not valid, show errors
      log('Form is not valid');
    }
  }
}
