import 'package:flutter/material.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';

class HoodScene extends StatefulWidget {
  final Function switchScene;

  const HoodScene({super.key, required this.switchScene});

  @override
  State<HoodScene> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HoodScene> {
  @override
  void initState() {
    Sounds.playHoodBgm();
    super.initState();
  }

  @override
  void dispose() {
    Sounds.stopBackgroundSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
