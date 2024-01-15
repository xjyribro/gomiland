import 'package:flutter/material.dart';
import 'package:gomiland/game/scenes/hood_scene.dart';

class GomilandGame extends StatefulWidget {
  const GomilandGame({super.key});

  @override
  State<GomilandGame> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<GomilandGame> {
  late Widget _scene;

  void switchScene(Widget newScene) {
    setState(() {
      _scene = newScene;
    });
  }

  @override
  void initState() {
    super.initState();
    _scene = HoodScene(switchScene: switchScene);
  }

  @override
  Widget build(BuildContext context) {
    return _scene;
  }
}
