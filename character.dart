import 'monster.dart';

class Character {
  String name;
  int health;
  int attackPower;
  int defensePower;

  Character(this.name, this.health, this.attackPower, this.defensePower);

  // ✅ 몬스터 공격
  void attackMonster(Monster monster) {
    int damage = attackPower;
    monster.health -= damage;
    print("$name이(가) ${monster.name}에게 ${damage}의 데미지를 입혔습니다.");
  }

  // ✅ 방어
  void defend() {
    print("$name이(가) 방어 자세를 취했습니다.");
  }

  // ✅ 상태 출력
  void showStatus() {
    print("$name - 체력: $health, 공격력: $attackPower, 방어력: $defensePower");
  }
}
