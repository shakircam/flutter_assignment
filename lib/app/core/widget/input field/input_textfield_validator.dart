import 'custom_text_field.dart';

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email cannot be empty';
  }
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  }
  if (value.length < 4) {
    return 'Password must be at least 4 characters';
  }
  return null;
}

String? validatePasswordConfirm(String? password, String confirmPassword) {
  if (password == null || password.isEmpty) {
    return 'Password cannot be empty';
  }
  if (password.length < 4) {
    return 'Password must be at least 4 characters';
  }
  if (password != confirmPassword) {
    return 'Passwords do not match';
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number cannot be empty';
  }
  final phoneRegex = RegExp(r'^\d{11}$');
  if (!phoneRegex.hasMatch(value)) {
    return 'Enter a valid phone number';
  }
  return null;
}

String? validateNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field cannot be empty';
  }
  final numberRegex = RegExp(r'^\d+$');
  if (!numberRegex.hasMatch(value)) {
    return 'Enter a valid number';
  }
  return null;
}

String? validateString(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field cannot be empty';
  }
  return null;
}

String? Function(String?) getValidator(InputFieldType fieldType) {
  switch (fieldType) {
    case InputFieldType.email:
      return validateEmail;
    case InputFieldType.password:
      return validatePassword;
    case InputFieldType.phoneNumber:
      return validatePhoneNumber;
    case InputFieldType.number:
      return validateNumber;
    case InputFieldType.text:
      return validateString;
    case InputFieldType.multiline:
      return validateString;
    default:
      return (_) => null;
  }
}
