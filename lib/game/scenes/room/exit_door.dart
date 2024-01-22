// import 'package:flame/components.dart';
// import 'package:flame/input.dart';
// import 'package:gomiland/game/controllers/game_state.dart';
//
// class ExitDoor extends ButtonComponent{
//
//   ExitDoor({
//     required Vector2 position,
//     required Vector2 size,
//     required Function switchScene,
//   }) : super(
//     position: position,
//     size: size,
//     onPressed: () {
//       print('tap');
//     },
//     button: PositionComponent(),
//     priority: 3,
//   ) {
//     _switchScene = switchScene;
//   }
//
//   late Function _switchScene;
//
//   @override
//   Future<void> onLoad() async {
//
//     print('pp');
//   }
// }