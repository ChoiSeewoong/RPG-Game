import 'dart:math';
import 'character.dart';

class Monster {
  String name;
  int health;
  late int attackPower;

  Monster(this.name, this.health, int maxAttackPower, int characterDefense) {
    attackPower = max(characterDefense, Random().nextInt(maxAttackPower) + 1);
  }

  void attackCharacter(Character character) {
    int damage = max(0, attackPower - character.defensePower);
    character.health -= damage;
    print("$name이(가) ${character.name}에게 ${damage}의 데미지를 입혔습니다.");
  }

  void showStatus() {
    print("$name - 체력: $health, 공격력: $attackPower");
  }
}
