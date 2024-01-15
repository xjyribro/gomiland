import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/game/buildings/home.dart';
import 'package:gomiland/game/components/pause_menu.dart';
import 'package:gomiland/game/player/player.dart';

class GomilandGame extends StatefulWidget {
  const GomilandGame({super.key});

  @override
  State<GomilandGame> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<GomilandGame> {
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
      overlayBuilderMap: {
        'pause' : (context, game) => PauseMenu(),
      },
      player: GPlayer(
        Vector2(32, 32),
      ),
      showCollisionArea: true,
    );
  }
}
