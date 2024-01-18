// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Prefs extends ChangeNotifier {

  bool _isMuted = false;

  bool get isMuted => _isMuted;

  void setIsMuted(bool isMuted) {
    _isMuted = isMuted;
    notifyListeners();
  }

}