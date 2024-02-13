import 'package:flutter/material.dart';

class SpacerNormal extends StatelessWidget {
  const SpacerNormal({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 20.0);
  }
}
class SpacerLarge extends StatelessWidget {
  const SpacerLarge({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 40.0);
  }
}
class SpacerSmall extends StatelessWidget {
  const SpacerSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 10.0);
  }
}

