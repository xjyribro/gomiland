import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/game/controllers/dialogue_controller.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/screens/main_menu.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }
  runApp(
    MultiProvider(
      providers: [
        BlocProvider<GameStateBloc>(create: (_) => GameStateBloc()),
        BlocProvider<DialogueBloc>(create: (_) => DialogueBloc()),
      ],
      child: const MyApp(),
    ),
  );
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
      home: const MainMenu(),
    );
  }
}
