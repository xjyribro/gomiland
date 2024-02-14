import 'package:flutter/material.dart';
import 'package:gomiland/screens/auth/sign_in.dart';
import 'package:gomiland/screens/credits.dart';
import 'package:gomiland/screens/main_menu.dart';
import 'package:gomiland/screens/settings.dart';

void goToSettings(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const SettingsPage(),
    ),
  );
}

void goToCredits(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const CreditsPage(),
    ),
  );
}

void goToSignIn(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const SignInPage(),
    ),
  );
}

void pushReplacementToMainMenu(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const MainMenu(),
    ),
  );
}