import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/core/values/app_colors.dart';
import 'package:flutter_assessment/app/core/values/app_values.dart';
import 'package:flutter_assessment/app/core/widget/button/gradient_button.dart';
import 'package:flutter_assessment/app/core/widget/button/ripple.dart';
import 'package:flutter_assessment/app/modules/setting/widget/image_avatar.dart';
import 'package:flutter_assessment/app/modules/setting/widget/theme_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

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
          _textView("John Smith", true, fontSize: 16),
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
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.black54),
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
    return Column(
      children: [
        _buildTextField('Email', 'youremail@xmail.com'),
        _buildTextField('Full Name', 'William Bennett'),
        _buildTextField('Street Address', '465 Nolan Causeway Suite 079'),
        _buildTextField('Apt, Suite, Bldg (optional)', 'Unit 512'),
        _buildTextField('Zip Code', '77017'),
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
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _labelText(label),
          SizedBox(
            height: 5.h,
          ),
          SizedBox(
            height: 45.h,
            child: TextFormField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  labelText: label,
                  labelStyle: const TextStyle(color: AppColors.neutralGray),
                  hintText: hint,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(8.0),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _labelText(String label) => Text(
        label,
        style: const TextStyle(color: Colors.black),
      );

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
            Navigator.pop(context);
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
      child: GradientButton(
          buttonText: "Apply",
          onTap: () {
            Navigator.pop(context);
          }),
    );
  }
}
