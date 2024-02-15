// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';

class ConfirmActionModal extends StatelessWidget {
  final Function onAccept;
  final String title;
  final String subTitle;

  const ConfirmActionModal({
    super.key,
    required this.onAccept,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyles.modalHeaderTextStyle,
      ),
      content: Text(
        subTitle,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onAccept();
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("No"),
        ),
      ],
    );
  }
}
