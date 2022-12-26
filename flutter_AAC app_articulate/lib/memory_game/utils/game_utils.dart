//Afiqah SUKD1802300
//Function for level 1

import 'package:flutter/material.dart';

class Game {
  final Color hiddenCard = Colors.red;
  List<Color>? gameColors;
  List<String>? gameImg;
  List<Color> cards = [
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.blue
  ];
  final String hiddenCardpath = "assets/game/hidden.png";
  // ignore: non_constant_identifier_names
  List<String> cards_list = [
    "assets/game/circle.png",
    "assets/game/triangle.png",
    "assets/game/circle.png",
    "assets/game/heart.png",
    "assets/game/star.png",
    "assets/game/triangle.png",
    "assets/game/star.png",
    "assets/game/heart.png",
  ];
  final int cardCount = 8;
  List<Map<int, String>> matchCheck = [];

  //methods
  void initGame() {
    gameColors = List.generate(cardCount, (index) => hiddenCard);
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
