import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/screens/widgets/dropdown_menu.dart';
import 'package:gomiland/screens/widgets/main_menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';
import 'package:gomiland/screens/widgets/text_input.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<String> genderOptions = ['Male', 'Female'];
  final _playerNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Country? _country;
  bool _isMale = true;

  void _onGenderSelect(String gender) {
    if (gender == genderOptions[0]) {
      setState(() {
        _isMale = true;
      });
    } else {
      setState(() {
        _isMale = false;
      });
    }
  }

  void _onCountrySelect(Country country) {
    setState(() {
      _country = country;
    });
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Player Name',
                        style: TextStyles.menuWhiteTextStyle,
                      ),
                      TextInput(controller: _playerNameController),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Avatar gender',
                        style: TextStyles.menuWhiteTextStyle,
                      ),
                      DropDownMenu(
                        options: genderOptions,
                        onSelect: _onGenderSelect,
                        chosenValue:
                            _isMale ? genderOptions[0] : genderOptions[1],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Country',
                        style: TextStyles.menuWhiteTextStyle,
                      ),
                      Text(
                        _country?.name ?? 'No country selected',
                        style: _country == null
                            ? TextStyles.menuRedTextStyle
                            : TextStyles.menuGreenTextStyle,
                      ),
                    ],
                  ),
                ),
                MainMenuButton(
                  onPressed: () {
                    showCountryPicker(
                      context: context,
                      onSelect: _onCountrySelect,
                    );
                  },
                  buttonWidth: 400,
                  text: 'Select your country',
                  style: TextStyles.menuPurpleTextStyle,
                ),
                const SpacerNormal(),
                MainMenuButton(
                  text: 'Save Settings',
                  style: TextStyles.menuGreenTextStyle,
                  onPressed: () {
                    _onSubmit();
                  },
                ),
                const SpacerNormal(),
                MainMenuButton(
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
