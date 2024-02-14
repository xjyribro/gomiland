import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final bool noMaxLen;
  final Widget? suffixIcon;
  final bool obscureText;

  const TextInput({
    super.key,
    required this.controller,
    required this.validator,
    required this.obscureText,
    this.noMaxLen = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: GameColors.black,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: suffixIcon,
        ),
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        maxLength: noMaxLen ? null : 30,
        style: TextStyles.menuBlackTextStyle,
      ),
    );
  }
}