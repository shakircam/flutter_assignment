import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/core/route/route_paths.dart';
import 'package:flutter_assessment/app/core/values/app_colors.dart';
import 'package:flutter_assessment/app/core/values/app_icons.dart';
import 'package:flutter_assessment/app/core/widget/image/asset_image_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatefulWidget {
  final String viewParam;
  const SignupPage({this.viewParam = ""});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isObsecured = true;

  @override
  void initState() {
    super.initState();
    _isObsecured = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50.0),
              AssetImageView(
                fileName: AppIcons.profileIcon,
                height: 100.h,
              ),
              const SizedBox(height: 20.0),
              // Email TextField
              textField("Name"),
              const SizedBox(height: 20.0),
              textField("Email"),
              const SizedBox(height: 20.0),
              // Password TextField
              _password(_passwordController, "Password"),
              const SizedBox(height: 20.0),
              _password(_confirmPasswordController, "Confirm Password"),
              const SizedBox(height: 60.0),
              _signupButton(),
              const SizedBox(height: 40.0),
              // Social Media Buttons
              AssetImageView(
                fileName: AppIcons.socialIcon,
                height: 50.h,
              ),
              const SizedBox(height: 40.0),
              _loginText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(String text) => TextField(
        style: TextStyle(color: AppColors.almostBlack),
        decoration: InputDecoration(
            labelText: text,
            labelStyle: TextStyle(color: AppColors.neutralGray),
            border: OutlineInputBorder(),
            prefixIcon: Icon(
              Icons.email,
              color: AppColors.neutralGray,
            ),
            filled: true,
            fillColor: AppColors.pure_white),
      );

  Widget _password(TextEditingController _passwordController, String hintText) {
    return TextFormField(
      controller: _passwordController,
      obscureText: _isObsecured,
      style: TextStyle(color: AppColors.almostBlack),
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(color: AppColors.neutralGray),
        border: OutlineInputBorder(),
        filled: true,
        fillColor: AppColors.pure_white,
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.grey,
        ),
        suffixIcon: _suffixIcon(),
      ),
    );
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
    return SizedBox(
      width: 300,
      child: ElevatedButton(
        onPressed: () {
          // Signup action
          context.go(RoutePaths.homePage);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, // Background color
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _suffixIcon() {
    return IconButton(
        onPressed: () {
          setState(() {
            _isObsecured = !_isObsecured;
          });
        },
        icon: _isObsecured
            ? const Icon(Icons.visibility, color: Colors.grey)
            : const Icon(Icons.visibility_off, color: Colors.grey));
  }
}
