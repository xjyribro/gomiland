import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/screens/menu.dart';
import 'package:gomiland/providers/game_state.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GameState()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'minecraft',
          fontSizeFactor: 2,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Menu(),
    );
  }
}
