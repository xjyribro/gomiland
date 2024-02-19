import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/firebase_options.dart';
import 'package:gomiland/controllers/day_controller.dart';
import 'package:gomiland/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/controllers/progress/progress_state_bloc.dart';
import 'package:gomiland/screens/main_menu.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (!kIsWeb) {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }
  runApp(
    MultiProvider(
      providers: [
        BlocProvider<GameStateBloc>(create: (_) => GameStateBloc()),
        BlocProvider<PlayerStateBloc>(create: (_) => PlayerStateBloc()),
        BlocProvider<ProgressStateBloc>(create: (_) => ProgressStateBloc()),
        BlocProvider<DayStateBloc>(create: (_) => DayStateBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
