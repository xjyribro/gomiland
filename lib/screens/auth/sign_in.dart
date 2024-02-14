import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/screens/auth/authentication.dart';
import 'package:gomiland/screens/auth/validations.dart';
import 'package:gomiland/screens/auth/widgets/apple_button.dart';
import 'package:gomiland/screens/auth/widgets/google_button.dart';
import 'package:gomiland/screens/auth/widgets/visibility_icon.dart';
import 'package:gomiland/screens/popups/popups.dart';
import 'package:gomiland/screens/settings.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';
import 'package:gomiland/screens/widgets/text_input.dart';

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

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    if (_isSignUp) {
      signUp(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
      ).then((hasValidSignIn) {
        if (hasValidSignIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SettingsPage(),
            ),
          );
        } else {
          Popups.showMessage(
            context: context,
            title: 'Unable to sign up',
            subTitle: 'Please check web connection and try again',
          );
        }
      });
    } else {
      signIn(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
      ).then((hasValidSignIn) {
        if (hasValidSignIn) {
          Navigator.pop(context);
        } else {
          Popups.showMessage(
            context: context,
            title: 'Unable to sign in',
            subTitle: 'Please check web connection and try again',
          );
        }
      });
    }
  }

  Future<void> _loginWithGoogle() async {
    if (_isLoading) return;
    _setIsLoading(true);
    await signInUpWithGoogle().onError((e, s) {
      Popups.showMessage(
        context: context,
        title: 'Unable to sign in with Google',
        subTitle: 'Please check web connection and try again',
      );
      return null;
    });
    _setIsLoading(false);
  }

  Future<void> _loginWithApple() async {
    if (_isLoading) return;
    _setIsLoading(true);
    await signInWithApple().onError((e, s) {
      Popups.showMessage(
        context: context,
        title: 'Unable to sign in with Apple',
        subTitle: 'Please check web connection and try again',
      );
      return null;
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
                          _passwordCheckController.text,
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
