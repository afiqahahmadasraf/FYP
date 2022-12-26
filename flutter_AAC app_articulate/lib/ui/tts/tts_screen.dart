//Afiqah SUKD1802300
//UI for tts screen

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

class TextToSpeech extends StatefulWidget {
  const TextToSpeech({Key? key}) : super(key: key);

  @override
  _TextToSpeechState createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech> {
  bool isSpeaking = false;
  final TextEditingController _controller = TextEditingController();
  final _flutterTts = FlutterTts();
  List<String>? languages;
  String langCode = "en-US";

  void initializeTts() {
    _flutterTts.setStartHandler(() {
      setState(() {
        isSpeaking = true;
      });
    });
    _flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });
    _flutterTts.setErrorHandler((message) {
      setState(() {
        isSpeaking = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initializeTts();
    init();
  }

  void _speak() async {
    if (_controller.text.isNotEmpty) {
      await _flutterTts.speak(_controller.text);
      await _flutterTts.setLanguage("en-UK");
      await _flutterTts.setSpeechRate(0.3);
      initSetting();
    }
  }

  void _stop() async {
    await _flutterTts.stop();
    setState(() {
      isSpeaking = false;
    });
  }

  void init() async {
    languages = List<String>.from(await _flutterTts.getLanguages);
    setState(() {});
  }

  void initSetting() async {
    await _flutterTts.setLanguage(langCode);
  }

  @override
  void dispose() {
    _flutterTts.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_rounded)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Voice Options: "),
                    Align(
                      alignment: Alignment.topRight,
                      child: DropdownButton<String>(
                          focusColor: Colors.white,
                          value: langCode,
                          style: const TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.black,
                          items: languages!
                              .map<DropdownMenuItem<String>>((String? value) {
                            return DropdownMenuItem<String>(
                              value: value!,
                              child: Text(
                                value,
                                style: const TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              langCode = value!;
                            });
                          }),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Text to Speech',
                  style: GoogleFonts.openSans(
                    textStyle:
                        const TextStyle(fontSize: 20, color: Colors.black),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Put in some words in the textbox and select the speak button.',
                  style: GoogleFonts.openSans(
                    textStyle:
                        const TextStyle(fontSize: 16, color: Colors.black),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _controller,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter some words!';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter some words",
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 40,
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent[100],
                    ),
                    // Within the `FirstRoute` widget
                    onPressed: () {
                      isSpeaking ? _stop() : _speak();
                    },
                    child: Text(
                      isSpeaking ? "Stop" : "Speak",
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
