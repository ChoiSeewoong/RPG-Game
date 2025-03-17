import 'dart:io';
import 'character.dart';
import 'monster.dart';
import 'game.dart';

String getCharacterName() {
  while (true) {
    stdout.write("캐릭터 이름을 입력하세요: ");
    String? input = stdin.readLineSync();

    if (input == null || input.trim().isEmpty) {
      print("❌ 캐릭터 이름은 비어있을 수 없습니다. 다시 입력하세요.");
      continue;
    }

    final validNameRegex = RegExp(r'^[a-zA-Z가-힣]+$');
    if (!validNameRegex.hasMatch(input)) {
      print("❌ 캐릭터 이름에는 숫자나 특수문자가 포함될 수 없습니다. 다시 입력하세요.");
      continue;
    }

    return input.trim();
  }
}

Future<void> saveGameResultAsync(Character player, bool isVictory) async {
  final file = File('result.txt');
  String result = isVictory ? "승리" : "패배";
  String content =
      "캐릭터 이름: ${player.name}\n남은 체력: ${player.health}\n게임 결과: $result\n";

  await file.writeAsString(content);
  print("✅ 게임 결과가 result.txt에 저장되었습니다!");
}

void main() async {
  String characterName = getCharacterName();

  Character player = Character(characterName, 50, 10, 5);

  List<Monster> monsters = [
    Monster("Goblin", 20, 10, player.defensePower),
    Monster("Orc", 30, 15, player.defensePower),
    Monster("Dragon", 50, 20, player.defensePower),
  ];

  Game game = Game(player, monsters);
  await game.startGame();
}
