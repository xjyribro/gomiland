import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/screens/auth/authentication.dart';
import 'package:gomiland/screens/auth/widgets/apple_button.dart';
import 'package:gomiland/screens/auth/widgets/google_button.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';
import 'package:gomiland/screens/widgets/text_input.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _playerNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _setIsLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
  }

  Future<void> _loginWithGoogle() async {
    if (_isLoading) return;
    _setIsLoading(true);
    await signInUpWithGoogle().onError((e, s) {
      // show err
      return null;
    });
    _setIsLoading(false);
  }


  Future<void> _loginWithApple() async {
    if (_isLoading) return;
    _setIsLoading(true);
    await signInWithApple().onError((e, s) {
      // show err
      return null;
    });
    _setIsLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Settings',
                  style: TextStyles.mainHeaderTextStyle,
                ),
                const Text(
                  'Player Name',
                  style: TextStyles.menuWhiteTextStyle,
                ),
                TextInput(controller: _playerNameController),
                const SpacerNormal(),
                const Text('Or sign in with'),
                GoogleButton(text: 'Sign in with Google', onPress: _loginWithGoogle),
                AppleButton(text: 'Sign in with Apple', onPress: _loginWithApple),
                const SpacerNormal(),
                MenuButton(
                  text: 'Back',
                  style: TextStyles.menuRedTextStyle,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SpacerNormal(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
