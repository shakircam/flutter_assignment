import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/core/route/route_paths.dart';
import 'package:flutter_assessment/app/core/values/app_colors.dart';
import 'package:flutter_assessment/app/core/values/app_icons.dart';
import 'package:flutter_assessment/app/core/widget/button/custom_button.dart';
import 'package:flutter_assessment/app/core/widget/image/asset_image_view.dart';
import 'package:flutter_assessment/app/core/widget/input%20field/custom_text_field.dart';
import 'package:flutter_assessment/app/data/remote/signup/model/user_signup_params.dart';
import 'package:flutter_assessment/app/modules/signup/controller/signup_controller.dart';
import 'package:flutter_assessment/app/utils/constants.dart';
import 'package:flutter_assessment/app/utils/snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  final String viewParam;
  const SignupPage({this.viewParam = ""});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameTextController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _nameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AssetImageView(
                  fileName: AppIcons.profileIcon,
                  height: 100.h,
                ),
                const SizedBox(height: 20.0),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Name TextField
                        _nameTextField(_nameTextController, "Name"),
                        const SizedBox(height: 10.0),
                        // Email TextField
                        _emailTextField(_emailController, "Email"),
                        const SizedBox(height: 10.0),
                        // Password TextField
                        _password(_passwordController, "Password"),
                        const SizedBox(height: 10.0),
                        // Confirm Password TextField
                        _password(
                            _confirmPasswordController, "Confirm Password",
                            confirmPasswordController: _passwordController),
                        const SizedBox(height: 20.0),
                        Consumer<SignupController>(
                            builder: (context, controller, _) {
                          return CustomButton(
                            onPressed: _submit,
                            text: 'Sign Up',
                            buttonColor: AppColors.checkboxColor,
                            textColor: Colors.white,
                            borderRadius: 8,
                            isLoading: controller.isLoading,
                          );
                        }),
                      ],
                    )),

                const SizedBox(height: 40.0),
                // Social Media Buttons
                AssetImageView(
                  fileName: AppIcons.socialIcon,
                  height: 50.h,
                ),
                const SizedBox(height: 20.0),
                _loginText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailTextField(TextEditingController controller, String text) =>
      CustomTextField(
          controller: controller,
          prefixIcon: const Icon(
            Icons.email,
            color: AppColors.neutralGray,
          ),
          hintText: text,
          fieldType: InputFieldType.email);

  Widget _nameTextField(TextEditingController controller, String text) =>
      CustomTextField(
          controller: controller,
          prefixIcon: const Icon(
            Icons.email,
            color: AppColors.neutralGray,
          ),
          hintText: text,
          fieldType: InputFieldType.text);

  Widget _password(TextEditingController passwordController, String hintText,
      {TextEditingController? confirmPasswordController}) {
    return CustomTextField(
        controller: passwordController,
        confirmController: confirmPasswordController,
        prefixIcon: const Icon(
          Icons.lock,
          color: AppColors.neutralGray,
        ),
        hintText: hintText,
        fieldType: InputFieldType.password);
  }

  Widget _loginText() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Already have an account? ',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: () {
              // Add your login navigation logic here
              context.go(RoutePaths.loginPage);
            },
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );

  Widget _signupButton() {
    return Consumer<SignupController>(builder: (context, controller, _) {
      return CustomButton(
        onPressed: _submit,
        text: 'Sign Up',
        buttonColor: AppColors.checkboxColor,
        textColor: Colors.white,
        borderRadius: 8,
        isLoading: controller.isLoading,
      );
    });
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with your logic
      log('Form is valid');
      UserSignupParams params = UserSignupParams(
          username: _nameTextController.text,
          email: _emailController.text,
          password: _passwordController.text);
      Provider.of<SignupController>(context, listen: false)
          .userSignup(params)
          .then((value) {
        if (value.code == SUCCESS) {
          context.go(RoutePaths.loginPage);
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
