//Afiqah SUKD1802300
//Function for level 2

import 'package:flutter/material.dart';

class Game1 {
  final Color hiddenCard1 = Colors.red;
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
    Colors.red
  ];
  final String hiddenCardpath1 = "assets/game/hidden.png";
  // ignore: non_constant_identifier_names
  List<String> cards_list1 = [
    "assets/game/zoo.png",
    "assets/game/rabbit.png",
    "assets/game/hippo.png",
    "assets/game/rabbit.png",
    "assets/game/parrot.png",
    "assets/game/panda.png",
    "assets/game/parrot.png",
    "assets/game/horse.png",
    "assets/game/hippo.png",
    "assets/game/horse.png",
    "assets/game/zoo.png",
    "assets/game/panda.png",
  ];
  final int cardCount = 12;
  List<Map<int, String>> matchCheck1 = [];

  //methods
  void initGame() {
    gameColors = List.generate(cardCount, (index) => hiddenCard1);
    gameImg = List.generate(cardCount, (index) => hiddenCardpath1);
  }
}
