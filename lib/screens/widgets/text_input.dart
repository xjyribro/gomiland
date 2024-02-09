import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;

  const TextInput({super.key, required this.controller});

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
              color: GameColors.blackTextColor,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        controller: controller,
        validator: (String? value) {
          final trimmed = (value == null) ? '' : value.trim();
          return (trimmed.isEmpty) ? 'Name required' : null;
        },
        maxLength: 30,
        style: TextStyles.menuBlackTextStyle,
      ),
    );
  }
}
