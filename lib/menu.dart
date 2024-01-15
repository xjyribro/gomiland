import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/game/game.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool showSplash = true;

  @override
  Widget build(BuildContext context) {
    return buildMenu();
    return showSplash ? buildSplash() : buildMenu(); // REPLACE
  }

  Widget buildMenu() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // gomiland logo
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    minimumSize: Size(100, 40), //////// HERE
                  ),
                  child: const Text('play'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GomilandGame()),
                    );
                  },
                  // choose input
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSplash() {
    return FlameSplashScreen(
      theme: FlameSplashTheme.dark,
      onFinish: (BuildContext context) {
        setState(() {
          showSplash = false;
        });
      },
    );
  }
}
