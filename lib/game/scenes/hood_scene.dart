import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/game/buildings/home.dart';
import 'package:gomiland/game/player/player.dart';

class HoodScene extends StatefulWidget {
  const HoodScene({super.key});

  @override
  State<HoodScene> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HoodScene> {
  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      map: WorldMapByTiled(
        TiledReader.asset('tiles/hood_base.json'),
        forceTileSize: Vector2(32, 32),
        objectsBuilder: {
          'home': (p) => Home(p.position, p.size),
        },
      ),
      joystick: Joystick(directional: JoystickDirectional()),
      player: GPlayer(
        Vector2(32, 32),
      ),
      showCollisionArea: true,
    );
  }
}
