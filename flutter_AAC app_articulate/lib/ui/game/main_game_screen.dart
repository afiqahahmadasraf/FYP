//Afiqah SUKD1802300
//UI for mmemory game screen

// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api, avoid_print, use_key_in_widget_constructors

import 'dart:async';

import 'package:articulate/memory_game/components/info_card.dart';
import 'package:articulate/memory_game/utils/game_utils.dart';
import 'package:articulate/memory_game/utils/game_utils1.dart';
import 'package:articulate/memory_game/utils/game_utils2.dart';
import 'package:articulate/ui/game/how_to_play.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MainGameScreen extends StatelessWidget {
  const MainGameScreen({Key? key, required this.child}) : super(key: key);
  final child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: SafeArea(
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded)),
          ),
        ),
        Center(
          child: Text('Memory Game',
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(fontSize: 28, color: Colors.black),
                fontWeight: FontWeight.w500,
              )),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 40,
          width: 180,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blueAccent[100],
            ),
            // Within the `FirstRoute` widget
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutGame()),
              );
            },
            child: Text(
              'HOW TO PLAY',
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const SizedBox(height: 100),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text('Select a level',
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(fontSize: 18, color: Colors.black),
                  fontWeight: FontWeight.w500,
                )),
          ),
        ),
        const SizedBox(height: 15),
        Card(
          color: Colors.blue.shade300,
          margin: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Level1()),
              );
            },
            splashColor: Colors.blueGrey.shade200,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Text("1", style: TextStyle(fontSize: 50.0)),
                ],
              ),
            ),
          ),
        ),
        Card(
          color: Colors.blue.shade300,
          margin: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Level2()),
              );
            },
            splashColor: Colors.blueGrey.shade200,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Text("2", style: TextStyle(fontSize: 50.0)),
                ],
              ),
            ),
          ),
        ),
        Card(
          color: Colors.blue.shade300,
          margin: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Level3()),
              );
            },
            splashColor: Colors.blueGrey.shade200,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Text("3", style: TextStyle(fontSize: 50.0)),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

class Levels extends StatefulWidget {
  const Levels({super.key});

  @override
  State<Levels> createState() => _LevelsState();
}

class _LevelsState extends State<Levels> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainGameScreen(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: GridView.count(
            crossAxisCount: 3,
            children: <Widget>[
              Card(
                color: Colors.blueGrey.shade200,
                margin: const EdgeInsets.all(5.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Level1()),
                    );
                  },
                  splashColor: Colors.blueGrey.shade200,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Text("1", style: TextStyle(fontSize: 50.0)),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.blueGrey.shade200,
                margin: const EdgeInsets.all(5.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Level2()),
                    );
                  },
                  splashColor: Colors.blueGrey.shade200,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Text("2", style: TextStyle(fontSize: 50.0)),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.blueGrey.shade200,
                margin: const EdgeInsets.all(5.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Level3()),
                    );
                  },
                  splashColor: Colors.blueGrey.shade200,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Text("3", style: TextStyle(fontSize: 50.0)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Manual extends StatefulWidget {
  const Manual({super.key});

  @override
  ManualState createState() => ManualState();
}

class ManualState extends State<Manual> {
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build

    return Scaffold(
      /* appBar: AppBar(
          title: new Text("Home Page"),
        ),*/
      backgroundColor: const Color.fromRGBO(239, 235, 233, 1),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: const <Widget>[
              SizedBox(height: 100.0),
              SizedBox(
                height: 120.0,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Image.asset('assets/images/manual.png', height: 700, width: 650),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          () => Get.offAndToNamed("/home");
        },
        label: const Text('Home'),
        icon: const Icon(Icons.home),
        backgroundColor: Colors.blue.shade100,
      ),
    );
  }
}

//Level 1

class Level1 extends StatefulWidget {
  const Level1({super.key});

  @override
  _Level1State createState() => _Level1State();
}

class _Level1State extends State<Level1> {
  //setting text style

  TextStyle whiteText = const TextStyle(color: Colors.white);
  bool hideTest = false;
  final Game _game = Game();

  //game stats
  int tries = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _game.initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 243, 244),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded)),
          ),
          const Center(
            child: Text(
              "Level 1",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              info_card("Taps", "$tries"),
              info_card("Points", "$score"),
            ],
          ),
          SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                  itemCount: _game.gameImg!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print(_game.matchCheck);
                        setState(() {
                          //incrementing the clicks
                          tries++;
                          _game.gameImg![index] = _game.cards_list[index];
                          _game.matchCheck
                              .add({index: _game.cards_list[index]});
                          print(_game.matchCheck.first);
                        });
                        if (_game.matchCheck.length == 2) {
                          if (_game.matchCheck[0].values.first ==
                              _game.matchCheck[1].values.first) {
                            print("true");
                            //incrementing the score
                            score += 10;
                            _game.matchCheck.clear();
                          } else {
                            print("false");

                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              print(_game.gameColors);
                              setState(() {
                                _game.gameImg![_game.matchCheck[0].keys.first] =
                                    _game.hiddenCardpath;
                                _game.gameImg![_game.matchCheck[1].keys.first] =
                                    _game.hiddenCardpath;
                                _game.matchCheck.clear();
                              });
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 152, 179, 238),
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage(_game.gameImg![index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}

//Level 2

class Level2 extends StatefulWidget {
  @override
  _Level2State createState() => _Level2State();
}

class _Level2State extends State<Level2> {
  //setting text style

  TextStyle whiteText = const TextStyle(color: Colors.white);
  bool hideTest = false;
  final Game1 _game1 = Game1();

  //game stats
  int tries = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _game1.initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 243, 244),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded)),
          ),
          const Center(
            child: Text(
              "Level 2",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              info_card("Taps", "$tries"),
              info_card("Points", "$score"),
            ],
          ),
          SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                  itemCount: _game1.gameImg!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 40.0,
                    mainAxisSpacing: 50.0,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print(_game1.matchCheck1);
                        setState(() {
                          //incrementing the clicks
                          tries++;
                          _game1.gameImg![index] = _game1.cards_list1[index];
                          _game1.matchCheck1
                              .add({index: _game1.cards_list1[index]});
                          print(_game1.matchCheck1.first);
                        });
                        if (_game1.matchCheck1.length == 2) {
                          if (_game1.matchCheck1[0].values.first ==
                              _game1.matchCheck1[1].values.first) {
                            print("true");
                            //incrementing the score
                            score += 10;
                            _game1.matchCheck1.clear();
                          } else {
                            print("false");

                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              print(_game1.gameColors);
                              setState(() {
                                _game1.gameImg![_game1.matchCheck1[0].keys
                                    .first] = _game1.hiddenCardpath1;
                                _game1.gameImg![_game1.matchCheck1[1].keys
                                    .first] = _game1.hiddenCardpath1;
                                _game1.matchCheck1.clear();
                              });
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 152, 179, 238),
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage(_game1.gameImg![index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}

//Level 3

class Level3 extends StatefulWidget {
  @override
  _Level3State createState() => _Level3State();
}

class _Level3State extends State<Level3> {
  //setting text style

  TextStyle whiteText = const TextStyle(color: Colors.white);
  bool hideTest = false;
  final Game2 _game2 = Game2();

  //game stats
  int tries = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _game2.initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 243, 244),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded)),
          ),
          const Center(
            child: Text(
              "Level 3",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              info_card("Taps", "$tries"),
              info_card("Points", "$score"),
            ],
          ),
          SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                  itemCount: _game2.gameImg!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 40.0,
                    mainAxisSpacing: 5.8,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print(_game2.matchCheck);
                        setState(() {
                          //incrementing the clicks
                          tries++;
                          _game2.gameImg![index] = _game2.cards_list[index];
                          _game2.matchCheck
                              .add({index: _game2.cards_list[index]});
                          print(_game2.matchCheck.first);
                        });
                        if (_game2.matchCheck.length == 2) {
                          if (_game2.matchCheck[0].values.first ==
                              _game2.matchCheck[1].values.first) {
                            print("true");
                            //incrementing the score
                            score += 10;
                            _game2.matchCheck.clear();
                          } else {
                            print("false");

                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              print(_game2.gameColors);
                              setState(() {
                                _game2.gameImg![_game2.matchCheck[0].keys
                                    .first] = _game2.hiddenCardpath;
                                _game2.gameImg![_game2.matchCheck[1].keys
                                    .first] = _game2.hiddenCardpath;
                                _game2.matchCheck.clear();
                              });
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 152, 179, 238),
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage(_game2.gameImg![index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
