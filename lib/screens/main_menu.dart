import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/controllers/audio_controller.dart';
import 'package:gomiland/game/ui/mute_button.dart';
import 'package:gomiland/screens/auth/utils.dart';
import 'package:gomiland/screens/popups/popups.dart';
import 'package:gomiland/screens/widgets/friends_button.dart';
import 'package:gomiland/screens/widgets/hi_score_button.dart';
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
  bool _isSignedIn = false;
  bool _isLoading = false;
  bool _isSentToProfile = false;
  final double _sidePadding = 16.0;

  void _setIsLoading(bool isLoading) {
    if (context.mounted) {
      setState(() {
        _isLoading = isLoading;
      });
    }
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
        ).then((hasData) async {
          if (!hasData && !_isSentToProfile) {
            _isSentToProfile = true;
            await goToProfile(context);
            _isSentToProfile = false;
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

  List<Widget> _menuButtons() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _sidePadding),
            child: MenuButton(
              text: 'New game',
              style: TextStyles.menuGreenTextStyle,
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
          ),
          _isSignedIn
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: _sidePadding),
                  child: LoadButton(
                    isLoading: _isLoading,
                    setIsLoading: _setIsLoading,
                  ),
                )
              : Container(),
        ],
      ),
      const SpacerNormal(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _sidePadding),
            child: MenuButton(
              text: 'Profile',
              style: TextStyles.menuPurpleTextStyle,
              onPressed: () {
                if (_isLoading) return;
                goToProfile(context);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _sidePadding),
            child: MenuButton(
              text: _isSignedIn ? 'Sign out' : 'Sign in',
              style: _isSignedIn
                  ? TextStyles.menuRedTextStyle
                  : TextStyles.menuPurpleTextStyle,
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
          ),
        ],
      ),
      const SpacerNormal(),
      _isSignedIn
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _sidePadding),
                  child: FriendsButton(
                    isLoading: _isLoading,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _sidePadding),
                  child: HiScoreButton(
                    isLoading: _isLoading,
                  ),
                ),
              ],
            )
          : Container(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _sidePadding),
            child: MenuButton(
              text: 'Code input',
              style: TextStyles.menuPurpleTextStyle,
              onPressed: () => goToCodeInput(context),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _sidePadding),
            child: MenuButton(
              text: 'Credits',
              style: TextStyles.menuPurpleTextStyle,
              onPressed: () {
                if (_isLoading) return;
                goToCredits(context);
              },
            ),
          ),
        ],
      ),
      const MuteButton(),
      const SpacerNormal(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool isWebMobile = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);
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
              if (isWebMobile)
                const Text(
                  'Gomiland is for desktop browsers only, for Android and iOS, please go to this page for more info',
                  textAlign: TextAlign.center,
                  style: TextStyles.menuWhiteTextStyle,
                )
              else
                ..._menuButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
