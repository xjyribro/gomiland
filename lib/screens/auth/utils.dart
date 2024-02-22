import 'package:flutter/cupertino.dart';
import 'package:gomiland/screens/popups/popups.dart';

void showSignInErrorPopup(BuildContext context, String errorMessage) {
  if (errorMessage == 'There is no user record') {
    Popups.showMessage(
      context: context,
      title: 'Email not found',
      subTitle:
      'If you have not created an account, press the "Sign Up" button',
    );
  } else if (errorMessage == 'The password is invalid') {
    Popups.showMessage(
      context: context,
      title: 'Incorrect password',
      subTitle:
      'Please try again',
    );
  } else {
    Popups.showMessage(
      context: context,
      title: 'Unable to sign in',
      subTitle: 'Please check web connection and try again',
    );
  }
}

void showSignUpErrorPopup(BuildContext context, String errorMessage) {
  if (errorMessage == 'The email address is already in use') {
    Popups.showMessage(
      context: context,
      title: 'Email already in use',
      subTitle:
      'Click "Change to sign in" above to sign in',
    );
  } else {
    Popups.showMessage(
      context: context,
      title: 'Unable to sign up',
      subTitle: 'Please check web connection and try again',
    );
  }
}