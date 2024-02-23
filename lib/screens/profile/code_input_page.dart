import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/screens/profile/widgets/profile_setting_row.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';
import 'package:gomiland/screens/widgets/text_input.dart';
import 'package:gomiland/utils/firestore.dart';
import 'package:gomiland/utils/validations.dart';

class CodeInputPage extends StatefulWidget {
  const CodeInputPage({super.key});

  @override
  State<CodeInputPage> createState() => _CodeInputPageState();
}

class _CodeInputPageState extends State<CodeInputPage> {
  final _codeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _setIsLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _setIsLoading(true);
    await getCode(_codeController.text).then((snapshot) {
      if (snapshot != null) {
        for (var element in snapshot.docs) {
          print(element);
        }}
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
                  'Redeem Code',
                  style: TextStyles.mainHeaderTextStyle,
                ),
                ProfileSettingRow(
                  children: [
                    const Text(
                      'Code',
                      style: TextStyles.menuWhiteTextStyle,
                    ),
                    TextInput(
                      controller: _codeController,
                      validator: codeValidator,
                      obscureText: false,
                    ),
                  ],
                ),
                MenuButton(
                  text: 'Submit',
                  style: TextStyles.menuGreenTextStyle,
                  onPressed: _onSubmit,
                  isLoading: _isLoading,
                ),
                const SpacerNormal(),
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
    );
  }
}
