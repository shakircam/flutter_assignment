import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/core/values/app_colors.dart';
import 'package:flutter_assessment/app/core/values/app_gradients.dart';
import 'package:flutter_assessment/app/core/values/app_values.dart';
import 'package:flutter_assessment/app/core/values/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ripple.dart';

class GradientButton extends StatelessWidget {
  final String buttonText;
  final Function()? onTap;
  final bool isLoading;

  const GradientButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: AppValues.maxButtonWidth.w,
        maxHeight: AppValues.maxButtonHeight.h,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(AppValues.radius_8)),
        gradient: AppGradients.datePickerGradient,
      ),
      child: Ripple(
        onTap: isLoading ? null : onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppValues.smallPadding.h,
            horizontal: AppValues.padding.w,
          ),
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.colorWhite),
                  ),
                )
              : Text(
                  buttonText,
                  style: datePickerSetButtonTextStyle,
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}
