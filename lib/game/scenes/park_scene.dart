import 'package:flutter/material.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';

class ParkScene extends StatefulWidget {
  final Function switchScene;

  const ParkScene({super.key, required this.switchScene});

  @override
  State<ParkScene> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ParkScene> {

  @override
  void initState() {
    Sounds.playParkBgm();
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
