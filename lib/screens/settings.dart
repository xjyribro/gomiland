import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/game/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/game/controllers/player_state.dart';
import 'package:gomiland/screens/widgets/dropdown_menu.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';
import 'package:gomiland/screens/widgets/text_input.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<String> genderOptions = ['Male', 'Female'];
  final List<String> showControlOptions = ['Yes', 'No'];
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

  void _onShowControlsSelect(BuildContext context, String showControls) {
    if (showControls == showControlOptions[0]) {
      context.read<PlayerStateBloc>().add(const ShowControls(true));
    } else {
      context.read<PlayerStateBloc>().add(const ShowControls(false));
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
    context.read<GameStateBloc>().add(SetIsMale(_isMale));
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
                        'Show joystick',
                        style: TextStyles.menuWhiteTextStyle,
                      ),
                      BlocBuilder<PlayerStateBloc, PlayerState>(
                          builder: (context, state) {
                        return DropDownMenu(
                          options: showControlOptions,
                          onSelect: (String showControls) {
                            _onShowControlsSelect(context, showControls);
                          },
                          chosenValue: state.showControls ? showControlOptions[0] : showControlOptions[1],
                        );
                      }),
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
                MenuButton(
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
                MenuButton(
                  text: 'Save Settings',
                  style: TextStyles.menuGreenTextStyle,
                  onPressed: () {
                    _onSubmit();
                  },
                ),
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
