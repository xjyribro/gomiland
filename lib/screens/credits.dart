import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';

class CreditsPage extends StatelessWidget{
  const CreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                Assets.assets_images_logo_gomiland_simple_png,
                height: 164,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                height: 20.0,
              ),

              const SizedBox(
                height: 20.0,
              ),

              const SizedBox(
                height: 20.0,
              ),

            ],
          ),
        ),
      ),
    );
  }
}