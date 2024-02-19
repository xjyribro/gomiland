import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/controllers/progress/progress_state_bloc.dart';
import 'package:gomiland/screens/popups/popups.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';
import 'package:gomiland/utils/firestore.dart';
import 'package:gomiland/utils/navigation.dart';

class LoadButton extends StatelessWidget {
  const LoadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgressStateBloc, ProgressState>(
        builder: (context, state) {
      if (state.hasSave) {
        return Column(
          children: [
            MenuButton(
              text: 'Load game',
              style: TextStyles.menuPurpleTextStyle,
              onPressed: () async {
                String? playerId = FirebaseAuth.instance.currentUser?.uid;
                if (playerId != null) {
                  await loadSaved(playerId: playerId, context: context)
                      .then((hasData) {
                    if (hasData) {
                      goToGame(context: context, loadFromSave: true);
                    } else {
                      Popups.showMessage(
                        context: context,
                        title: 'Load error',
                        subTitle: 'No data to load',
                      );
                    }
                  });
                }
              },
            ),
            const SpacerNormal(),
          ],
        );
      }
      return Container();
    });
  }
}
