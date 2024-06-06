import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/core/values/app_colors.dart';

extension CustomSnackbarExtension on BuildContext {
  void showSnackbar(String message,
      {Duration duration = const Duration(seconds: 2)}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.checkboxColor,
        content: Text(
          message,
          style: const TextStyle(color: AppColors.white),
        ),
        duration: duration,
      ),
    );
  }
}
