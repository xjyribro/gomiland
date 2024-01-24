import 'dart:io';

import 'package:flutter/material.dart';

class MobileKeypad extends StatelessWidget{
  const MobileKeypad({super.key});

  @override
  Widget build(BuildContext context) {
    if (!(Platform.isIOS || Platform.isAndroid)) return Container();
    return ElevatedButton(onPressed: () {}, child: Text('t'));
  }
}