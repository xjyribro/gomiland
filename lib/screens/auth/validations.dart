
String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "* required";
  } else if (value.length < 6) {
    return 'Password must be more than 6 characters';
  } else {
    return null;
  }
}

String? emailValidator(String? value) {
  return (value == null || !checkEmail(value))
      ? 'Enter a valid email'
      : null;
}

bool checkEmail(String email) {
  return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
      .hasMatch(email);
}