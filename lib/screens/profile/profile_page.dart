import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/screens/popups/popups.dart';
import 'package:gomiland/screens/profile/widgets/profile_setting_row.dart';
import 'package:gomiland/screens/widgets/dropdown_menu.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';
import 'package:gomiland/screens/widgets/text_input.dart';
import 'package:gomiland/utils/firestore.dart';
import 'package:gomiland/utils/validations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _playerNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Country? _country;
  bool _isMale = true;
  bool _isLoading = false;

  void _setIsLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

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
      context.read<GameStateBloc>().add(const ShowControls(true));
    } else {
      context.read<GameStateBloc>().add(const ShowControls(false));
    }
  }

  void _onCountrySelect(Country country) {
    setState(() {
      _country = country;
    });
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_country == null) {
      Popups.showMessage(
        context: context,
        title: 'Please select a country',
        subTitle: '',
      );
      return;
    }
    _setIsLoading(true);
    String playerName = _playerNameController.text;
    String country = _country!.name;
    context.read<PlayerStateBloc>().state.setPlayerState(
          context: context,
          playerName: playerName,
          country: country,
          isMale: _isMale,
        );
    String? playerId = FirebaseAuth.instance.currentUser?.uid;
    if (playerId != null) {
      await savePlayerInfo(
        playerId: playerId,
        playerName: playerName,
        country: country,
        isMale: _isMale,
      );
    }
    _setIsLoading(false);
    if (context.mounted) Navigator.pop(context, true);
  }

  void _initForm() {
    _isMale = context.read<PlayerStateBloc>().state.isMale;
    _playerNameController.text =
        context.read<PlayerStateBloc>().state.playerName;
    _country = Country.tryParse(context.read<PlayerStateBloc>().state.country);
  }

  @override
  void initState() {
    super.initState();
    _initForm();
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
                  'Profile',
                  style: TextStyles.mainHeaderTextStyle,
                ),
                const SpacerNormal(),
                ProfileSettingRow(
                  children: [
                    const Text(
                      'Player Name',
                      style: TextStyles.menuWhiteTextStyle,
                    ),
                    TextInput(
                      controller: _playerNameController,
                      validator: playerNameValidator,
                      obscureText: false,
                    ),
                  ],
                ),
                ProfileSettingRow(
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
                ProfileSettingRow(
                  children: [
                    const Text(
                      'Show joystick',
                      style: TextStyles.menuWhiteTextStyle,
                    ),
                    BlocBuilder<GameStateBloc, GameState>(
                        builder: (context, state) {
                      return DropDownMenu(
                        options: showControlOptions,
                        onSelect: (String showControls) {
                          _onShowControlsSelect(context, showControls);
                        },
                        chosenValue: state.showControls
                            ? showControlOptions[0]
                            : showControlOptions[1],
                      );
                    }),
                  ],
                ),
                ProfileSettingRow(
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
                MenuButton(
                  onPressed: () {
                    showCountryPicker(
                      context: context,
                      onSelect: _onCountrySelect,
                    );
                  },
                  text: 'Select your country',
                  style: TextStyles.menuPurpleTextStyle,
                  buttonWidth: 320,
                ),
                const SpacerNormal(),
                MenuButton(
                  text: 'Save and return to main menu',
                  style: TextStyles.menuGreenTextStyle,
                  onPressed: () {
                    _onSubmit();
                  },
                  isLoading: _isLoading,
                  buttonWidth: 320,
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
