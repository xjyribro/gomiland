import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/screens/popups/popups.dart';
import 'package:gomiland/screens/profile/utils.dart';
import 'package:gomiland/screens/profile/widgets/players_list.dart';
import 'package:gomiland/screens/profile/widgets/request_friend_row.dart';
import 'package:gomiland/screens/widgets/dropdown_menu.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';
import 'package:gomiland/screens/widgets/text_input.dart';
import 'package:gomiland/utils/firestore.dart';
import 'package:gomiland/utils/other_player.dart';

class SearchPlayers extends StatefulWidget {
  const SearchPlayers({super.key});

  @override
  State<SearchPlayers> createState() => _SearchPlayersState();
}

class _SearchPlayersState extends State<SearchPlayers> {
  final _playerNameController = TextEditingController();
  Country? _country;
  bool _isMale = true;
  bool _isLoading = false;
  Map<String, OtherPlayer> _playersList = {};

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

  void _onCountrySelect(Country country) {
    setState(() {
      _country = country;
    });
  }

  void _setPlayersList(Map<String, OtherPlayer> playersList) {
    setState(() {
      _playersList = playersList;
    });
  }

  Future<void> _onSearch() async {
    _setIsLoading(true);
    await _searchPlayers();
    _setIsLoading(false);
  }

  Future<void> _searchPlayers() async {
    String? playerName =
        _playerNameController.text != '' ? _playerNameController.text : null;
    QuerySnapshot<Object?>? result = await getPlayers(
      playerName: playerName,
      country: _country?.name,
    );
    if (result != null) {
      if (context.mounted) {
        List<String> friendsList =
            context.read<PlayerStateBloc>().state.friendsList;
        _setPlayersList(getPlayersFromSearchResult(result, friendsList));
      }
    } else {
      if (context.mounted) {
        Popups.showMessage(
          context: context,
          title: 'Error in searching database',
          subTitle: '',
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _searchPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Search Player Name',
                style: TextStyles.menuWhiteTextStyle,
              ),
              TextInput(
                controller: _playerNameController,
                validator: (String? name) => null,
                obscureText: false,
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
                'Avatar gender',
                style: TextStyles.menuWhiteTextStyle,
              ),
              DropDownMenu(
                options: genderOptions,
                onSelect: _onGenderSelect,
                chosenValue: _isMale ? genderOptions[0] : genderOptions[1],
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
        MenuButton(
          onPressed: () {
            showCountryPicker(
              context: context,
              onSelect: _onCountrySelect,
            );
          },
          text: 'Select country',
          style: TextStyles.menuPurpleTextStyle,
        ),
        const SpacerNormal(),
        MenuButton(
          text: 'Search',
          style: TextStyles.menuGreenTextStyle,
          onPressed: () async {
            await _onSearch();
          },
          isLoading: _isLoading,
        ),
        const Text(
          'Search results',
          style: TextStyles.mainHeaderTextStyle,
        ),
        const SpacerNormal(),
        const RequestFriendRow(
          name: 'Name',
          country: 'Country',
          daysInGame: 'Days in game',
          isSendRequest: true,
        ),
        const SpacerNormal(),
        _playersList.isNotEmpty
            ? PlayersList(
                playersList: _playersList,
                isSendRequest: true,
              )
            : const Text(
                'No results to show',
                style: TextStyles.mainHeaderTextStyle,
              ),
        const SpacerNormal(),
      ],
    );
  }
}
