import 'package:flutter/material.dart';

class SignInFormField extends StatelessWidget {
  final String label;
  final Widget? suffixIcon;
  final Function? validator;
  final bool obscureText;
  final TextEditingController controller;

  const SignInFormField({
    super.key,
    required this.label,
    required this.obscureText,
    required this.controller,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText,
      controller: controller,
      validator: (String? value) {
        if (validator == null) return null;
        return validator!(value);
      },
    );
  }
}
