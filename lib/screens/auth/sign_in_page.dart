import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/screens/auth/authentication.dart';
import 'package:gomiland/screens/auth/utils.dart';
import 'package:gomiland/screens/auth/validations.dart';
import 'package:gomiland/screens/auth/widgets/apple_button.dart';
import 'package:gomiland/screens/auth/widgets/google_button.dart';
import 'package:gomiland/screens/auth/widgets/visibility_icon.dart';
import 'package:gomiland/screens/popups/popups.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';
import 'package:gomiland/screens/widgets/text_input.dart';
import 'package:gomiland/utils/firestore.dart';
import 'package:gomiland/utils/navigation.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordCheckController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isSignUp = false;
  bool _isPasswordVisible = false;
  bool _isPasswordCheckVisible = false;

  void _setIsLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void _toggleIsSignUp() {
    setState(() {
      _isSignUp = !_isSignUp;
    });
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_isLoading) return;
    _setIsLoading(true);
    if (_isSignUp) {
      await signUp(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
      ).then((errorMessage) {
        if (errorMessage != null) {
          showSignUpErrorPopup(context, errorMessage);
        } else {
          pushReplacementToSettings(context);
        }
      });
    } else {
      await signIn(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
      ).then((errorMessage) async {
        if (errorMessage != null) {
          showSignInErrorPopup(context, errorMessage);
        } else {
          String? playerId = FirebaseAuth.instance.currentUser?.uid;
          if (playerId != null) {
            await loadSaved(playerId: playerId, context: context)
                .then((hasData) {
              if (hasData) {
                Navigator.pop(context);
              } else {
                goToSettings(context);
              }
            });
          }
        }
      });
    }
    _setIsLoading(false);
  }

  Future<void> _loginWithGoogle() async {
    if (_isLoading) return;
    _setIsLoading(true);
    await signInUpWithGoogle()
        .then((value) => Navigator.pop(context))
        .onError((e, s) {
      Popups.showMessage(
        context: context,
        title: 'Unable to sign in with Google',
        subTitle: 'Please check web connection and try again',
      );
    });
    _setIsLoading(false);
  }

  Future<void> _loginWithApple() async {
    if (_isLoading) return;
    _setIsLoading(true);
    await signInWithApple()
        .then((value) => Navigator.pop(context))
        .onError((e, s) {
      Popups.showMessage(
        context: context,
        title: 'Unable to sign in with Apple',
        subTitle: 'Please check web connection and try again',
      );
    });
    _setIsLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    _isSignUp ? 'Sign up' : 'Sign in',
                    style: TextStyles.mainHeaderTextStyle,
                  ),
                  MenuButton(
                    onPressed: _toggleIsSignUp,
                    text: 'Change to ${_isSignUp ? 'Sign In' : 'Sign Up'}',
                    isLoading: _isLoading,
                  ),
                  const SpacerNormal(),
                  const Text(
                    'Email',
                    style: TextStyles.menuWhiteTextStyle,
                  ),
                  TextInput(
                    controller: _emailController,
                    noMaxLen: true,
                    validator: emailValidator,
                    obscureText: false,
                  ),
                  const SpacerNormal(),
                  const Text(
                    'Password',
                    style: TextStyles.menuWhiteTextStyle,
                  ),
                  TextInput(
                    controller: _passwordController,
                    noMaxLen: true,
                    validator: passwordValidator,
                    obscureText: !_isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: VisibilityIcon(isVisible: _isPasswordVisible),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  const SpacerNormal(),
                  if (_isSignUp) ...[
                    const Text(
                      'Retype password',
                      style: TextStyles.menuWhiteTextStyle,
                    ),
                    TextInput(
                      controller: _passwordCheckController,
                      noMaxLen: true,
                      validator: (String? value) {
                        return passwordCheckValidator(
                          value,
                          _passwordController.text,
                        );
                      },
                      obscureText: !_isPasswordCheckVisible,
                      suffixIcon: IconButton(
                        icon:
                            VisibilityIcon(isVisible: _isPasswordCheckVisible),
                        onPressed: () {
                          setState(() {
                            _isPasswordCheckVisible = !_isPasswordCheckVisible;
                          });
                        },
                      ),
                    ),
                    const SpacerNormal()
                  ],
                  MenuButton(
                    onPressed: _onSubmit,
                    text: _isSignUp ? 'Sign up' : 'Sign in',
                    isLoading: _isLoading,
                  ),
                  const SpacerNormal(),
                  const Text('Or sign in with'),
                  const SpacerNormal(),
                  GoogleButton(
                      text: 'Sign in with Google', onPress: _loginWithGoogle),
                  const SpacerNormal(),
                  AppleButton(
                      text: 'Sign in with Apple', onPress: _loginWithApple),
                  const SpacerLarge(),
                  MenuButton(
                    text: 'Back',
                    style: TextStyles.menuRedTextStyle,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    isLoading: _isLoading,
                  ),
                  const SpacerNormal(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
