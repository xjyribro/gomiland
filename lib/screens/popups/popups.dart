import 'package:flutter/material.dart';
import 'package:gomiland/screens/popups/info_modal.dart';

import 'confirm_action_modal.dart';

class Popups {
  static showUnsavableWarning({
    required BuildContext context,
    required Function onAccept,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmActionModal(
          onAccept: onAccept,
          title:
              'You are not logged in.\nYou will not be able to save your progress.',
          subTitle: 'Continue?',
        );
      },
    );
  }

  static showSaveOverrideWarning({
    required BuildContext context,
    required Function onAccept,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return ConfirmActionModal(
          onAccept: onAccept,
          title:
          'You are saving over a previous save',
          subTitle: 'Continue?',
        );
      },
    );
  }

  static showMessage({
    required BuildContext context,
    required title,
    required subTitle,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return InfoModal(
          title: title,
          subTitle: subTitle,
        );
      },
    );
  }
}
