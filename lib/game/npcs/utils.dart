import 'dart:math';

import 'package:flame/components.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/controllers/progress/progress_state_bloc.dart';
import 'package:gomiland/game/data/other_player.dart';
import 'package:gomiland/game/data/rubbish/rubbish_type.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/objects/obstacle.dart';
import 'package:gomiland/game/scenes/utils.dart';

class NpcNameStrings {
  static const String boy = 'boy';
  static const String girl = 'girl';
  static const String man = 'man';
  static const String woman = 'woman';
  static const String unknown = 'unknown';
}

enum NpcName { boy, girl, man, woman, unknown }

extension NpcNameExtension on NpcName {
  String get string {
    switch (this) {
      case NpcName.boy:
        return NpcNameStrings.boy;
      case NpcName.girl:
        return NpcNameStrings.girl;
      case NpcName.man:
        return NpcNameStrings.man;
      case NpcName.woman:
        return NpcNameStrings.woman;
      default:
        return NpcNameStrings.unknown;
    }
  }
}

extension GetNpcName on String {
  NpcName get npcName {
    switch (this) {
      case NpcNameStrings.boy:
        return NpcName.boy;
      case NpcNameStrings.girl:
        return NpcName.girl;
      case NpcNameStrings.man:
        return NpcName.man;
      case NpcNameStrings.woman:
        return NpcName.woman;
      default:
        return NpcName.unknown;
    }
  }
}

int getCharProgress(RubbishType rubbishType, ProgressState state) {
  switch (rubbishType) {
    case RubbishType.plastic:
      return state.risa;
    case RubbishType.paper:
      return state.qianBi;
    case RubbishType.electronics:
      return state.asimov;
    case RubbishType.glass:
      return state.manuka;
    case RubbishType.metal:
      return state.stark;
    case RubbishType.food:
      return state.moon;
    default:
      return 0;
  }
}

Obstacle npcObstacle(Vector2 position) => Obstacle(
      position: Vector2(position.x + 6, position.y),
      size: Vector2(20, 32),
    );

String getTimeOfDay(int minutes) {
  if (minutes >= morningStartMins && minutes < afternoonStartMins) {
    return 'morning';
  } else if (minutes >= afternoonStartMins && minutes < eveningStartMins) {
    return 'afternoon';
  } else {
    return 'evening';
  }
}

String getFriendDialogue(OtherPlayer friendInfo, GomilandGame game) {
  if (friendInfo.daysInGame < 10) {
    return 'new_player';
  } else {
    bool playerCompletedMainQuests = checkFriendMainQuestsCompleted(friendInfo);
    int playerSpeed = game.playerStateBloc.state.playerSpeed;
    int bagSize = game.gameStateBloc.state.bagSize;
    if (playerCompletedMainQuests) {
      if (playerSpeed > playerBaseSpeed && bagSize > largeBagSize) {
        return 'seasoned_player';
      } else {
        if (playerSpeed > playerBaseSpeed) {
          // only allow buying a big bag if player has a medium bag
          if (bagSize == mediumBagSize) {
            return 'buy_bag';
          } else {
            return 'progress_player';
          }
        } else if (bagSize > 10) {
          return 'buy_shoe';
        }
        int rand = Random().nextInt(2);
        return rand == 0 ? 'buy_bag' : 'buy_shoe';
      }
    }
    return 'progress_player';
  }
}

String getZenGardenSellerDialogue(
    Map<String, bool> zenGarden, String charName) {
  switch (charName) {
    case 'hardy':
      if (zenGarden.containsKey(ZenStrings.rock_4)) {
        return zenGarden[ZenStrings.rock_4]!
            ? ZenStrings.post_buy
            : ZenStrings.buy;
      }
    case 'brocky':
      if (zenGarden.containsKey(ZenStrings.rock_1)) {
        return zenGarden[ZenStrings.rock_1]!
            ? ZenStrings.post_buy
            : ZenStrings.buy;
      }
    case 'brock':
      if (zenGarden.containsKey(ZenStrings.rock_2)) {
        return zenGarden[ZenStrings.rock_2]!
            ? ZenStrings.post_buy
            : ZenStrings.buy;
      }
    case 'rocky':
      if (zenGarden.containsKey(ZenStrings.rock_3)) {
        return zenGarden[ZenStrings.rock_3]!
            ? ZenStrings.post_buy
            : ZenStrings.buy;
      }
    case 'florence':
      if (zenGarden.containsKey(ZenStrings.bonsai_1)) {
        return zenGarden[ZenStrings.bonsai_1]!
            ? ZenStrings.post_buy
            : ZenStrings.buy;
      }
    case 'peach':
      if (zenGarden.containsKey(ZenStrings.bonsai_2)) {
        return zenGarden[ZenStrings.bonsai_2]!
            ? ZenStrings.post_buy
            : ZenStrings.buy;
      }
    case 'margret':
      if (zenGarden.containsKey(ZenStrings.bonsai_3)) {
        return zenGarden[ZenStrings.bonsai_3]!
            ? ZenStrings.post_buy
            : ZenStrings.buy;
      }
  }
  return ZenStrings.pre_buy;
}

void deductCoins(GomilandGame game, int price) {
  game.gameStateBloc.add(ChangeCoinAmount(-price));
}
