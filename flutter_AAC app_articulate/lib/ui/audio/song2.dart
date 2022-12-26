//Afiqah SUKD1802300
//UI for song 2

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Song2 extends StatefulWidget {
  const Song2({super.key});

  @override
  State<Song2> createState() => _Song2State();
}

class _Song2State extends State<Song2> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  void initState() {
    super.initState();

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();

    super.dispose();
  }

  Future setAudio() async {
    //repeat song when complete
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);

    //Load file from assets
    final player = AudioCache(prefix: 'assets/');
    final url = await player.load('old_macdonald_had_a_farm.mp3');
    audioPlayer.setUrl(url.path, isLocal: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded)),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
                "https://img.freepik.com/free-vector/old-macdonald-farm-nursery-rhymes-scene_1308-54992.jpg?w=996&t=st=1669212250~exp=1669212850~hmac=bb4aea3f7ac884318001acd17dcb09bdd593eba9ed3d8b3622cb251f4200c0d8"),
          ),
          const SizedBox(height: 32),
          const Text("Old Macdonald"),
          Slider(
            min: 0,
            max: duration.inSeconds.toDouble() + 1.0,
            value: position.inSeconds.toDouble(),
            onChanged: (value) async {
              final position = Duration(seconds: value.toInt());
              await audioPlayer.seek(position);
              await audioPlayer.resume();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(position)),
                  Text(formatTime(duration)),
                ]),
          ),
          CircleAvatar(
            radius: 35,
            child: IconButton(
                onPressed: () async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    await audioPlayer.resume();
                  }
                },
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                iconSize: 50),
          ),
        ]),
      )),
    );
  }
}
