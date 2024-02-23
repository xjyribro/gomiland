import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/screens/profile/utils.dart';

class CodeMerchantsList extends StatelessWidget {
  const CodeMerchantsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerStateBloc, PlayerState>(
      builder: (context, state) {
        Map<String, bool> zenGarden = state.zenGarden;
        List<Widget> newCodeRedeemedInfo = [];
        zenGarden.forEach((objectName, isBought) {
          (String, String)? record = getMerchantAndLocation(objectName);
          if (!isBought && record != null) {
            String merchantName = record.$1;
            String location = record.$2;
            newCodeRedeemedInfo.add(
              Text(
                'You can buy a new ${getObjectName(objectName)} from $merchantName $location',
                textAlign: TextAlign.center,
                style: TextStyles.menuWhiteTextStyle,
              ),
            );
          }
        });
        if (newCodeRedeemedInfo.isEmpty) {
          return const Center(
              child: Text(
            'No new codes redeemed',
            style: TextStyles.menuWhiteTextStyle,
          ));
        }
        return Column(
          children: newCodeRedeemedInfo,
        );
      },
    );
  }
}
