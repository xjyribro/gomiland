import 'package:flutter/material.dart';

class ProfileSettingRow extends StatelessWidget {
  final List<Widget> children;

  const ProfileSettingRow({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }
}
