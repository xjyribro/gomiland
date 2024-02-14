import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/ui/mute_button.dart';
import 'package:gomiland/screens/auth/sign_in.dart';
import 'package:gomiland/screens/credits.dart';
import 'package:gomiland/screens/popups/popups.dart';
import 'package:gomiland/screens/settings.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool _showSplash = true;
  bool _isSignedIn = false;

  void _initAuthStateListener() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (!mounted) return;
      if (user == null) {
        setState(() {
          _isSignedIn = false;
        });
      } else {
        print(user);
        setState(() {
          _isSignedIn = true;
        });
      }
    });
  }

  @override
  void initState() {
    Sounds.playMainMenuBgm();
    _initAuthStateListener();
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
    return _showSplash ? buildSplash() : buildMenu(); // TODO REPLACE
  }

  void _goToGame() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) {
    //     context.read<GameStateBloc>().add(const SceneChanged(SceneName.hood));
    //     return const GameWidgetWrapper();
    //   }),
    // );
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
                  Popups.showUnsavableWarning(
                    context: context,
                    onAccept: _goToGame,
                  );
                },
              ),
              const SpacerNormal(),
              MenuButton(
                text: _isSignedIn ? 'Load game' : 'Sign in',
                style: TextStyles.menuPurpleTextStyle,
                onPressed: () {
                  if (!_isSignedIn) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInPage(),
                      ),
                    );
                    return;
                  }
                  // load saved from firestore
                  // if no saved game, go new game
                  _goToGame();
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
          _showSplash = false;
        });
      },
    );
  }
}
