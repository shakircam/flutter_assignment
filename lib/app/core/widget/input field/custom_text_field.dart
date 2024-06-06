import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/core/values/app_colors.dart';

import 'input_textfield_validator.dart';

enum InputFieldType { email, password, phoneNumber, number, text, multiline }

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      this.controller,
      required this.hintText,
      this.obscureCharacter = '*',
      required this.fieldType,
      this.prefixIcon,
      this.suffixIcon,
      this.radius = 10.0,
      this.maxLength,
      this.initialValue,
      this.textAlign = TextAlign.start,
      this.readOnly = false,
      this.maxLines = 1,
      this.minLines,
      this.isRequired = false,
      this.padding,
      this.confirmController})
      : super(key: key);

  final TextEditingController? controller;
  final String hintText;
  final String? initialValue;
  final String? obscureCharacter;
  final InputFieldType fieldType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double radius;
  final int? maxLength;
  final TextAlign textAlign;
  final bool readOnly;
  final int maxLines;
  final int? minLines;
  final EdgeInsets? padding;
  final bool isRequired;
  final TextEditingController? confirmController;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  var _isObsecured;

  @override
  void initState() {
    super.initState();
    _isObsecured = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(8.0),
      child: Column(
        children: [if (widget.isRequired) _requiredField(), _textFormField()],
      ),
    );
  }

  Widget _textFormField() {
    return TextFormField(
      initialValue: widget.initialValue,
      textAlign: widget.textAlign,
      controller: widget.controller,
      style: const TextStyle(color: AppColors.almostBlack),
      keyboardType: _getKeyboardType(widget.fieldType),
      maxLength: widget.maxLength,
      obscureText:
          widget.fieldType == InputFieldType.password ? _isObsecured : false,
      onTapOutside: (event) => FocusScope.of(context).requestFocus(FocusNode()),
      obscuringCharacter: widget.obscureCharacter!,
      validator: (value) {
        if (widget.fieldType == InputFieldType.password &&
            widget.confirmController != null) {
          return validatePasswordConfirm(value, widget.confirmController!.text);
        }
        return getValidator(widget.fieldType)(value);
      },
      decoration: _decoration(),
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
    );
  }

  Widget _requiredField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            widget.hintText,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12.0,
            ),
          ),
          const Icon(
            Icons.star,
            color: Colors.red,
            size: 12.0,
          ),
        ],
      ),
    );
  }

  TextInputType _getKeyboardType(InputFieldType fieldType) {
    switch (fieldType) {
      case InputFieldType.email:
        return TextInputType.emailAddress;
      case InputFieldType.password:
        return TextInputType.text;
      case InputFieldType.phoneNumber:
        return TextInputType.phone;
      case InputFieldType.number:
        return TextInputType.number;
      case InputFieldType.multiline:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  InputDecoration _decoration() => InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(fontSize: 12, color: AppColors.neutralGray),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide.none,
        ),
        counterText: '',
        prefixIcon: widget.prefixIcon,
        suffixIcon: _suffixIcon(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide.none,
        ),
        fillColor: AppColors.pure_white,
        filled: true,
        contentPadding:
            const EdgeInsets.only(left: 16, right: 10, top: 10, bottom: 10),
      );

  Widget? _suffixIcon() {
    return widget.fieldType == InputFieldType.password
        ? IconButton(
            onPressed: () {
              setState(() {
                _isObsecured = !_isObsecured;
              });
            },
            icon: _isObsecured
                ? const Icon(Icons.visibility, color: Colors.grey)
                : const Icon(Icons.visibility_off, color: Colors.grey))
        : widget.suffixIcon;
  }
}
