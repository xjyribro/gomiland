import 'package:flutter/material.dart';
import 'package:gomiland/game/game.dart';

Widget PauseMenu() {
  return Center(
    child: Container(
      width: 100,
      height: 100,
      color: Colors.orange,
      child: const Center(
        child: Text('Paused'),
      ),
    ),
  );
}
