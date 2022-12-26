//Afiqah SUKD1802300
//Function for level 3

import 'package:flutter/material.dart';

class Game2 {
  final Color hiddenCard = Colors.red;
  List<Color>? gameColors;
  List<String>? gameImg;
  List<Color> cards = [
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.blue,
    Colors.red,
    Colors.red,
    Colors.pink,
    Colors.pink
  ];
  final String hiddenCardpath = "assets/game/hidden.png";
  // ignore: non_constant_identifier_names
  List<String> cards_list = [
    "assets/game/pineapple.png",
    "assets/game/apple.png",
    "assets/game/cherry.png",
    "assets/game/carrot.png",
    "assets/game/orange.png",
    "assets/game/cherry.png",
    "assets/game/lemon.png",
    "assets/game/raspberry.png",
    "assets/game/lemon.png",
    "assets/game/apple.png",
    "assets/game/orange.png",
    "assets/game/pineapple.png",
    "assets/game/raspberry.png",
    "assets/game/carrot.png",
    "assets/game/strawberry.png",
    "assets/game/strawberry.png",
  ];
  final int cardCount = 16;
  List<Map<int, String>> matchCheck = [];

  //methods
  void initGame() {
    gameColors = List.generate(cardCount, (index) => hiddenCard);
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
