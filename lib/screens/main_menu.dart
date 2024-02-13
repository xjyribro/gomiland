import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/ui/mute_button.dart';
import 'package:gomiland/screens/credits.dart';
import 'package:gomiland/screens/settings.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
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
              const SpacerNormal(),
              MenuButton(
                text: 'New game',
                style: TextStyles.menuPurpleTextStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      context
                          .read<GameStateBloc>()
                          .add(const SceneChanged(SceneName.hood));
                      return const GameWidgetWrapper();
                    }),
                  );
                },
              ),
              const SpacerNormal(),
              MenuButton(
                text: 'Load game',
                style: TextStyles.menuPurpleTextStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GameWidgetWrapper()),
                  );
                },
              ),
              const SpacerNormal(),
              MenuButton(
                text: 'Settings',
                style: TextStyles.menuPurpleTextStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                },
              ),
              const SpacerNormal(),
              MenuButton(
                text: 'Credits',
                style: TextStyles.menuPurpleTextStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreditsPage(),
                    ),
                  );
                },
              ),
              const MuteButton(),
              const SpacerNormal(),
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
