import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/controllers/audio_controller.dart';
import 'package:gomiland/game/ui/mute_button.dart';
import 'package:gomiland/screens/auth/utils.dart';
import 'package:gomiland/screens/popups/popups.dart';
import 'package:gomiland/screens/widgets/load_button.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';
import 'package:gomiland/utils/authentication.dart';
import 'package:gomiland/utils/firestore.dart';
import 'package:gomiland/utils/navigation.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool _showSplash = true;
  bool _isSignedIn = false;
  bool _isLoading = false;

  void _setIsLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void _initAuthStateListener() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (!mounted) return;
      if (user == null) {
        setState(() {
          _isSignedIn = false;
        });
      } else {
        setState(() {
          _isSignedIn = true;
        });
        loadSaved(
          playerId: user.uid,
          context: context,
        ).then((hasData) {
          if (!hasData) {
            goToSettings(context);
          }
        });
      }
    });
  }

  @override
  void initState() {
    Sounds.initialize();
    Sounds.playMainMenuBgm();
    _initAuthStateListener();
    super.initState();
  }

  @override
  void dispose() {
    Sounds.stopBackgroundSound();
    Sounds.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildMenu();
    return _showSplash ? buildSplash() : buildMenu(); // TODO REPLACE
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
                  if (_isLoading) return;
                  _setIsLoading(true);
                  if (!_isSignedIn) {
                    Popups.showUnsavableWarning(
                      context: context,
                      onAccept: () =>
                          goToGame(context: context, loadFromSave: false),
                    );
                  } else {
                    goToGame(context: context, loadFromSave: false);
                  }
                  _setIsLoading(false);
                },
              ),
              const SpacerNormal(),
              _isSignedIn
                  ? LoadButton(
                      isLoading: _isLoading,
                      setIsLoading: _setIsLoading,
                    )
                  : Container(),
              MenuButton(
                text: _isSignedIn ? 'Sign out' : 'Sign in',
                style: TextStyles.menuPurpleTextStyle,
                onPressed: () async {
                  if (_isLoading) return;
                  if (!_isSignedIn) {
                    goToSignIn(context);
                    return;
                  } else {
                    await signOut().then((_) => resetBlocStates(context));
                  }
                },
              ),
              const SpacerNormal(),
              MenuButton(
                text: 'Profile',
                style: TextStyles.menuPurpleTextStyle,
                onPressed: () {
                  if (_isLoading) return;
                  goToSettings(context);
                },
              ),
              const SpacerNormal(),
              MenuButton(
                text: 'Credits',
                style: TextStyles.menuPurpleTextStyle,
                onPressed: () {
                  if (_isLoading) return;
                  goToCredits(context);
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
