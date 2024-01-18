import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/uiInterface/mute_button.dart';
import 'package:gomiland/screens/credits.dart';
import 'package:gomiland/screens/instructions.dart';
import 'package:gomiland/screens/settings.dart';
import 'package:gomiland/screens/widgets/mainMenuButton.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool showSplash = true;

  @override
  void initState() {
    Sounds.playMainMenuBgm();
    super.initState();
  }

  @override
  void dispose() {
    Sounds.stopBackgroundSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildMenu();
    return showSplash ? buildSplash() : buildMenu(); // REPLACE
  }

  Widget buildMenu() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                Assets.assets_images_logo_gomiland_simple_png,
                height: 164,
              ),
              const SizedBox(
                height: 20.0,
              ),
              MainMenuButton(
                text: 'New game',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GameWidgetWrapper()),
                  );
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              MainMenuButton(
                text: 'Load game',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GameWidgetWrapper()),
                  );
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              MainMenuButton(
                text: 'Settings',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()),
                  );
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              MainMenuButton(
                text: 'How to play',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Instructions()),
                  );
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              MainMenuButton(
                text: 'Credits',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreditsPage()),
                  );
                },
              ),
              const MuteButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSplash() {
    return FlameSplashScreen(
      theme: FlameSplashTheme.dark,
      onFinish: (BuildContext context) {
        setState(() {
          showSplash = false;
        });
      },
    );
  }
}
