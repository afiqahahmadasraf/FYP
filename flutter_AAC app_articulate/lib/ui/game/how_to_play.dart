//Afiqah SUKD1802300
//UI for how to play screen

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutGame extends StatefulWidget {
  const AboutGame({super.key});

  @override
  State<AboutGame> createState() => _AboutGameState();
}

class _AboutGameState extends State<AboutGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.lightBlue[50],
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "How to Play?",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(fontSize: 18),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              tileColor: Colors.blue.shade200,
              title: Text(
                "1. Select a level",
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(fontSize: 15),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              tileColor: Colors.blue.shade200,
              title: Text(
                "2. Select a tile to flip the image",
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(fontSize: 15),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              tileColor: Colors.blue.shade200,
              title: Text(
                "3. Match the tiles to make a pair",
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(fontSize: 15),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              tileColor: Colors.blue.shade200,
              title: Text(
                "4. Try to complete the game with the least amount of taps as possible",
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(fontSize: 15),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ]),
      ),
    ));
  }
}
