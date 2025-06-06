part of 'shared.dart';

String? requiredValidator(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return "$fieldName field is required";
  }
  return null;
}

String? numberValidator(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return "$fieldName field is required";
  }
  final number = num.tryParse(value);
  if (number == null) {
    return "$fieldName must be a valid number";
  }
  return null;
}

String? requiredImageValidator(File? image, String fieldName) {
  if (image == null) {
    return "$fieldName is required";
  }
  return null;
}

String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Name field is required";
  }
  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email field is required';
  } else if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return "Please enter a valid email address";
  } else {
    return null;
  }
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password field is required';
  } else if (value.length < 8) {
    return 'Password must be at least 8 characters';
  } else {
    return null;
  }
}

String? confirmPasswordValidator(
    String? value, TextEditingController passwordController) {
  if (value == null || value.isEmpty) {
    return 'Confirm password field is required';
  } else if (value.length < 8) {
    return 'Confirm Password must be at least 8 characters';
  } else if (value != passwordController.text) {
    return "Password field and confirm password field must be the same";
  } else {
    return null;
  }
}