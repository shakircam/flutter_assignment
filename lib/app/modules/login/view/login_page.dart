import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/core/route/route_paths.dart';
import 'package:flutter_assessment/app/core/values/app_colors.dart';
import 'package:flutter_assessment/app/core/values/app_icons.dart';
import 'package:flutter_assessment/app/core/widget/image/asset_image_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _passwordController = TextEditingController();

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
      body: Center(
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
              // Email TextField
              TextField(
                style: const TextStyle(color: AppColors.almostBlack),
                decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: AppColors.neutralGray),
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: AppColors.neutralGray,
                    ),
                    filled: true,
                    fillColor: AppColors.pure_white),
              ),
              SizedBox(height: 20.0),
              // Password TextField
              TextFormField(
                controller: _passwordController,
                obscureText: _isObsecured,
                style: TextStyle(color: AppColors.almostBlack),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: AppColors.neutralGray),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: AppColors.pure_white,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
                  suffixIcon: _suffixIcon(),
                ),
              ),
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
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    // Login action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Background color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),

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
                  // Navigate to create account screen
                  context.go(RoutePaths.signupPage);
                },
                child: const Text(
                  'Create New Account',
                  style: TextStyle(
                      color: Colors.grey, decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
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
