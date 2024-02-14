import 'package:flutter/material.dart';

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
            subTitle: 'Continue?');
      },
    );
  }
}
