import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/core/route/route_paths.dart';
import 'package:flutter_assessment/app/core/services/service_locator.dart';
import 'package:flutter_assessment/app/core/values/app_colors.dart';
import 'package:flutter_assessment/app/core/values/app_values.dart';
import 'package:flutter_assessment/app/core/widget/button/custom_button.dart';
import 'package:flutter_assessment/app/core/widget/button/gradient_button.dart';
import 'package:flutter_assessment/app/core/widget/button/ripple.dart';
import 'package:flutter_assessment/app/core/widget/input%20field/custom_text_field.dart';
import 'package:flutter_assessment/app/data/local/preference/pref_manager.dart';
import 'package:flutter_assessment/app/data/remote/user%20update/model/user_update_params.dart';
import 'package:flutter_assessment/app/modules/setting/controller/setting_controller.dart';
import 'package:flutter_assessment/app/modules/setting/widget/image_avatar.dart';
import 'package:flutter_assessment/app/modules/setting/widget/theme_dialog.dart';
import 'package:flutter_assessment/app/utils/constants.dart';
import 'package:flutter_assessment/app/utils/snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _formKey = GlobalKey<FormState>();
  final _expansionController = ExpansionTileController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  String firstName = "John";
  String lastName = "Smith";

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: const Text(
          "My Account",
          style: TextStyle(color: AppColors.almostBlack),
        ),
      ),
      body: ListView(
        children: [
          const ImageAvatar(),
          const SizedBox(
            height: 30,
          ),
          _textView("$firstName $lastName", true, fontSize: 16),
          _textView("info@johnsmith.com", false),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              width: 300, // Adjust width as needed
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildAccountSection(context),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.lock,
                    text: "Passwords",
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.notifications,
                    text: "Notification",
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.favorite_border,
                    text: "Wishlist (00)",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _textView(String text, bool isBold, {double? fontSize}) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : null,
            color: AppColors.almostBlack),
      ),
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    return ExpansionTile(
      controller: _expansionController,
      leading: const Icon(Icons.account_circle, color: Colors.black54),
      title: const Text(
        'Account',
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
      children: [
        _buildAccountForm(context),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(
        text,
        style:
            const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[300],
      thickness: 1.0,
      height: 1.0,
    );
  }

  Widget _buildAccountForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
              isRequired: true,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              controller: _firstNameController,
              hintText: 'First name',
              hasBorder: true,
              fieldType: InputFieldType.text),
          CustomTextField(
              isRequired: true,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              controller: _lastNameController,
              hintText: 'Last name',
              hasBorder: true,
              fieldType: InputFieldType.text),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCancelButton(context),
              const SizedBox(width: 16),
              _buildSaveButton(context),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return Expanded(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: AppValues.maxButtonWidth.w,
          maxHeight: AppValues.maxButtonHeight.h,
        ),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.0),
            borderRadius:
                const BorderRadius.all(Radius.circular(AppValues.radius_8)),
            color: AppColors.white),
        child: Ripple(
          onTap: () {
            _expansionController.collapse();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppValues.smallPadding.h,
              horizontal: AppValues.padding.w,
            ),
            child: const Text(
              "Cancel",
              style: TextStyle(color: AppColors.colorBlack),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Expanded(
      child: Consumer<SettingController>(
        builder: (context, controller, _) {
          return GradientButton(
              buttonText: "Apply",
              isLoading: controller.isLoading,
              onTap: _updateUserInfo);
        },
      ),
    );
  }

  void _updateUserInfo() async {
    if (_formKey.currentState!.validate()) {
      UserUpdateParams params = UserUpdateParams(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text);
      Provider.of<SettingController>(context, listen: false)
          .userUpdate(params)
          .then((value) {
        if (value.userName.isNotEmpty) {
          context.showSnackbar('Update Successfully');
          _expansionController.collapse();
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
