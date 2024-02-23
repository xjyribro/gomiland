import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/screens/popups/popups.dart';
import 'package:gomiland/screens/profile/widgets/code_merchants_list.dart';
import 'package:gomiland/screens/profile/widgets/profile_setting_row.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';
import 'package:gomiland/screens/widgets/text_input.dart';
import 'package:gomiland/utils/code_object.dart';
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
    await getCode(_codeController.text).then((snapshot) async {
      if (snapshot == null) {
        showCodeNotFound();
        return;
      }
      if (snapshot.docs.isEmpty) {
        showCodeNotFound();
        return;
      }
      DocumentSnapshot doc = snapshot.docs[0];
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      CodeObject codeObject = CodeObject.fromJson(data);
      if (codeObject.count == 0) {
        showCodeFullyRedeemed();
        return;
      }
      await redeemCode(doc, codeObject.count - 1).then((success) {
        if (success) {
          Map<String, bool> zenGardenState =
              updateZenGardenState(codeObject.object);
          savePlayerZenGardenToDb(zenGardenState);
          showRedemptionSuccess();
        }
      });
    });
    _setIsLoading(false);
  }

  Map<String, bool> updateZenGardenState(String newObject) {
    Map<String, bool> zenGarden =
        context.read<PlayerStateBloc>().state.zenGarden;
    zenGarden[newObject] = false;
    context.read<PlayerStateBloc>().add(SetZenGarden(zenGarden));
    return zenGarden;
  }

  void showRedemptionSuccess() {
    Popups.showMessage(
      context: context,
      title: 'Code redemption success!',
      subTitle: '',
    );
  }

  void showCodeNotFound() {
    Popups.showMessage(
      context: context,
      title: 'Code not found',
      subTitle: '',
    );
  }

  void showCodeFullyRedeemed() {
    Popups.showMessage(
      context: context,
      title: 'This code has been fully redeemed',
      subTitle: '',
    );
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
                const Text(
                  'Redeemable objects',
                  style: TextStyles.mainHeaderTextStyle,
                ),
                const SpacerNormal(),
                const CodeMerchantsList(),
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
