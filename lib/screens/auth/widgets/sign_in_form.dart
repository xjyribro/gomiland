import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/screens/auth/authentication.dart';
import 'package:gomiland/screens/auth/validations.dart';
import 'package:gomiland/screens/auth/widgets/visibility_icon.dart';
import 'package:gomiland/screens/auth/widgets/sign_in_form_field.dart';

class LoginForm extends StatefulWidget {
  final bool isLoading;
  final Function setIsLoading;
  final Function setIsLogin;

  const LoginForm({
    super.key,
    required this.setIsLoading,
    required this.isLoading,
    required this.setIsLogin,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> _login() async {
    if (widget.isLoading) return;
    widget.setIsLoading(true);
    if (_formKey.currentState!.validate()) {
      await login(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
      ).then((value) => {if (mounted) widget.setIsLoading(false)});
    }
    widget.setIsLoading(false);
  }

  Future<void> _resendVerificationEmail() async {
    if (widget.isLoading) return;
    widget.setIsLoading(true);
    if (_formKey.currentState!.validate()) {
      await login(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
      );
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      await signOut();
    }
    if (mounted) widget.setIsLoading(false);
  }

  Future<void> _sendResetPasswordEmail() async {
    if (_emailController.text.trim() == '') {
      if (kDebugMode) {
        print('email not valid');
      }
    }
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: _emailController.text.trim())
        .then((_) {
      if (kDebugMode) {
        print('password reset sent');
      }
    }).onError((e, s) {
      if (e.toString() ==
          '[firebase_auth/invalid-email] The email address is badly formatted.') {
        if (kDebugMode) {
          print(e);
        }
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SignInFormField(
              label: 'Enter email',
              obscureText: false,
              controller: _emailController,
              validator: emailValidator,
            ),
            const SizedBox(
              height: 24,
            ),
            SignInFormField(
              label: 'Enter password',
              suffixIcon: IconButton(
                icon: VisibilityIcon(isVisible: _isPasswordVisible),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              obscureText: !_isPasswordVisible,
              controller: _passwordController,
              validator: passwordValidator,
            ),
            const SizedBox(
              height: 28,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                await _login();
              },
              child: const Text('Sign in'),
            ),
            TextButton(
              onPressed: () {
                _sendResetPasswordEmail();
              },
              child: Text(
                'Forgot password',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                _resendVerificationEmail();
              },
              child: Text(
                'Send verification email',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
