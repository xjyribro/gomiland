import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/game/buildings/home.dart';
import 'package:gomiland/game/components/park_entrance.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/controllers/game_controller.dart';
import 'package:gomiland/game/player/player.dart';

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
  Widget build(BuildContext context) {
    return BonfireWidget(
      map: WorldMapByTiled(
        TiledReader.asset('tiles/hood_base.json'),
        forceTileSize: Vector2(32, 32),
        objectsBuilder: {
          'home': (p) => Home(p.position, p.size),
          'park_entrance': (p) => ParkEntrance(p.position, p.size, switchScene: widget.switchScene),
        },
      ),
      joystick: Joystick(directional: JoystickDirectional()),
      overlayBuilderMap: {
        // g-coins
        // bag
        // menu button
        // sound?
      },
      components: [ GameController() ],
      player: GPlayer(
        Vector2(32, 32),
      ),
      showCollisionArea: true,
    );
  }
}
