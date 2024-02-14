import 'package:flutter/material.dart';
import 'package:gomiland/screens/auth/authentication.dart';
import 'package:gomiland/screens/auth/validations.dart';
import 'package:gomiland/screens/auth/widgets/visibility_icon.dart';
import 'package:gomiland/screens/auth/widgets/sign_in_form_field.dart';

class SignupForm extends StatefulWidget {
  final bool isLoading;
  final Function setIsLoading;
  final Function setIsLogin;

  const SignupForm({
    super.key,
    required this.setIsLoading,
    required this.isLoading,
    required this.setIsLogin,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordRetypeController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isPassword2Visible = false;

  Future<void> _signUp() async {
    if (widget.isLoading) return;
    widget.setIsLoading(true);
    if (_formKey.currentState!.validate()) {
      await signUp(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
      ).then((value) => widget.setIsLogin(true));
    }
    widget.setIsLoading(false);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordRetypeController.dispose();
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
            Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                SignInFormField(
                  label: 'Retype password',
                  suffixIcon: IconButton(
                    icon: VisibilityIcon(isVisible: _isPassword2Visible),
                    onPressed: () {
                      setState(() {
                        _isPassword2Visible = !_isPassword2Visible;
                      });
                    },
                  ),
                  obscureText: !_isPassword2Visible,
                  controller: _passwordRetypeController,
                  validator: (String? value) {
                    return (value != null &&
                        value != _passwordController.text)
                        ? 'passwords do not match'
                        : null;
                  },
                ),
              ],
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
                await _signUp();
              },
              child: const Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
