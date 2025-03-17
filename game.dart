import 'dart:io';
import 'dart:math';
import 'character.dart';
import 'main.dart';
import 'monster.dart';

class Game {
  Character player;
  List<Monster> monsters;

  Game(this.player, this.monsters);

  // ✅ 랜덤으로 몬스터 선택
  Monster getRandomMonster() {
    return monsters[Random().nextInt(monsters.length)];
  }

  // ✅ 전투 진행
  void battle(Monster monster) {
    while (player.health > 0 && monster.health > 0) {
      print("\n${player.name}의 턴");
      print("행동을 선택하세요 (1: 공격, 2: 방어): ");
      String? action = stdin.readLineSync();

      if (action == '1') {
        player.attackMonster(monster);
      } else if (action == '2') {
        player.defend();
      } else {
        print("잘못된 입력입니다. 다시 선택하세요.");
        continue;
      }

      if (monster.health <= 0) {
        print("\n${monster.name}을(를) 물리쳤습니다!");
        monsters.remove(monster);
        break;
      }

      print("\n${monster.name}의 턴");
      monster.attackCharacter(player);

      player.showStatus();
      monster.showStatus();
    }
  }

  // ✅ 게임 시작
  Future<void> startGame() async {
    print("게임을 시작합니다!");
    player.showStatus();

    while (player.health > 0 && monsters.isNotEmpty) {
      Monster monster = getRandomMonster();
      print("\n새로운 몬스터가 나타났습니다!");
      monster.showStatus();

      battle(monster);

      if (player.health <= 0) {
        print("\n💀 ${player.name}이(가) 쓰러졌습니다. 게임 오버!");
        await saveGameResultAsync(player, false);
        break;
      }

      if (monsters.isEmpty) {
        print("\n🎉 모든 몬스터를 처치했습니다! 승리!");
        await saveGameResultAsync(player, true);
        break;
      }

      print("\n다음 몬스터와 싸우시겠습니까? (y/n): ");
      String? choice = stdin.readLineSync();
      if (choice?.toLowerCase() != 'y') {
        print("\n게임을 종료합니다.");
        await saveGameResultAsync(player, false);
        break;
      }
    }
  }
}
