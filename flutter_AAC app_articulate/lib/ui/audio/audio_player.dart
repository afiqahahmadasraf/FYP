//Afiqah SUKD1802300
//UI for audio player screen

import 'package:articulate/ui/audio/song1.dart';
import 'package:articulate/ui/audio/song2.dart';
import 'package:articulate/ui/audio/song3.dart';
import 'package:articulate/ui/audio/song4.dart';
import 'package:articulate/ui/audio/song5.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AudioPlayer extends StatefulWidget {
  const AudioPlayer({super.key});

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
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
                "Nursery Rhymes Player",
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
              trailing: const Icon(Icons.star),
              tileColor: Colors.yellow.shade200,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Song1()),
                );
              },
              title: Text(
                "Twinkle Twinkle Little Star",
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              trailing: const FaIcon(FontAwesomeIcons.cow),
              tileColor: Colors.green.shade200,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Song2()),
                );
              },
              title: Text(
                "Old Macdonald",
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              trailing: const FaIcon(FontAwesomeIcons.personDress),
              tileColor: Colors.pink.shade200,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Song3()),
                );
              },
              title: Text(
                "Mary Had a Little Lamb",
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              trailing: const FaIcon(FontAwesomeIcons.car),
              tileColor: Colors.blue.shade200,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Song4()),
                );
              },
              title: Text(
                "Papa ku Pulang Dari Kota",
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              trailing: const FaIcon(FontAwesomeIcons.kiwiBird),
              tileColor: Colors.purple.shade200,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Song5()),
                );
              },
              title: Text(
                "Bangau oh Bangau",
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
        ]),
      ),
    ));
  }
}
