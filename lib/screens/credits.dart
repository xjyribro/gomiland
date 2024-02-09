import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/screens/widgets/credits_entry.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Credits',
                style: TextStyles.mainHeaderTextStyle,
              ),
              const SpacerNormal(),
              const Text(
                'Thanks for playing!',
                style: TextStyles.menuPurpleTextStyle,
              ),
              const SpacerNormal(),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Game design & Coding',
                          style: TextStyles.menuRedTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        SpacerSmall(),
                        CreditsEntry(
                          name: 'Lim Chee Keen',
                          country: 'Singapore',
                        ),
                        CreditsEntry(
                          name: 'Email',
                          country: 'limcheekeen.63\n@gmail.com',
                          removeBrackets: true,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Art & Design',
                          style: TextStyles.menuOrangeTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        CreditsEntry(
                          name: 'Hong Yeu Wing',
                          country: 'Singapore',
                        ),
                        CreditsEntry(
                          name: 'Amelia Yeo',
                          country: 'Singapore',
                        ),
                        CreditsEntry(
                          name: 'Lim Chee Keen',
                          country: 'Singapore',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Music and sound',
                          style: TextStyles.menuGreenTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        CreditsEntry(
                          name: 'Parker Clendening',
                          country: 'USA',
                        ),
                        CreditsEntry(
                          name: 'Iori Goto',
                          country: 'Japan',
                        ),
                      ],
                    ),
                  ),
                ],
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
    );
  }
}
