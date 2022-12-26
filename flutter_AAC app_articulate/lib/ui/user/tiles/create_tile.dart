// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class CreateTiles extends StatefulWidget {
  const CreateTiles({super.key});

  @override
  State<CreateTiles> createState() => _CreateTilesState();
}

class _CreateTilesState extends State<CreateTiles> {
  File? _image;
  String imageUrl = '';
  TextEditingController title = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  // ignore: unused_field
  late String _textSpeech;

  final CollectionReference _reference = FirebaseFirestore.instance
      .collection('main_user_collection')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("user_tiles");

  final ref = FirebaseFirestore.instance.collection("main_user_collection");

  @override
  void initState() {
    getUsers();
    _speech = stt.SpeechToText();
    super.initState();
  }

  getUsers() {
    ref.get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        print(doc.data());
      }
    });
  }

  void onListen() async {
    bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'));

    if (!_isListening) {
      if (available) {
        setState(() {
          _isListening = false;
          _speech.listen(
            onResult: (val) => setState(() {
              _textSpeech = val.recognizedWords;
              title.text = val.recognizedWords;
            }),
          );
        });
      }
    } else {
      setState(() {
        _isListening = false;
        _speech.stop();
      });
    }
  }

  void stopListen() {
    _speech.stop();
    setState(() {});
  }

  @override
  void dispose() {
    title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Form(
              key: key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  RotatedBox(
                    quarterTurns: 4,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          alignment: Alignment.topLeft,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_rounded)),
                    ),
                  ),
                  Text(
                    'Create Tile',
                    style: GoogleFonts.openSans(
                      textStyle:
                          const TextStyle(fontSize: 23, color: Colors.black),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _image != null
                      ? Image.file(_image!,
                          width: 200, height: 200, fit: BoxFit.cover)
                      : Image.asset('assets/img/skeleton_image.png',
                          height: 200, width: 200),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent[100],
                      ),
                      onPressed: () async {
                        //Get user's image and display preview on screen
                        XFile? image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        print('${image?.path}');
                        if (image == null) return;

                        final imageTemporary = File(image.path);

                        setState(() {
                          _image = imageTemporary;
                        });

                        //Upload img to db
                        // ignore: unnecessary_null_comparison
                        if (image == null) return;
                        String uniqueFileName =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        Reference refRoot = FirebaseStorage.instance.ref();
                        Reference refDirImages =
                            refRoot.child('user_cat_images');
                        Reference refImageToUpload =
                            refDirImages.child(uniqueFileName);
                        try {
                          await refImageToUpload.putFile(File(image.path));
                          imageUrl = await refImageToUpload.getDownloadURL();
                          // ignore: empty_catches
                        } catch (e) {}
                      },
                      child: Text(
                        'SELECT IMAGE FROM GALLERY',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent[100],
                      ),
                      onPressed: () async {
                        //Get user's image and display preview on screen
                        XFile? image = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        print('${image?.path}');
                        if (image == null) return;

                        final imageTemporary = File(image.path);

                        setState(() {
                          _image = imageTemporary;
                        });

                        //Upload img to db
                        // ignore: unnecessary_null_comparison
                        if (image == null) return;
                        String uniqueFileName =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        Reference refRoot = FirebaseStorage.instance.ref();
                        Reference refDirImages =
                            refRoot.child('user_cat_images');
                        Reference refImageToUpload =
                            refDirImages.child(uniqueFileName);
                        try {
                          await refImageToUpload.putFile(File(image.path));
                          imageUrl = await refImageToUpload.getDownloadURL();
                          // ignore: empty_catches
                        } catch (e) {}
                      },
                      child: Text(
                        'TAKE A PICTURE WITH CAMERA',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: Text("Label",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        )),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: title,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the tile label';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter the name of the tile",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Voice Recorder",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        )),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        "Tap the mic to record. Tap the pause button to stop recording",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 10, color: Colors.black),
                        )),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: onListen,
                        child: const FaIcon(FontAwesomeIcons.microphone),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () => stopListen(),
                        child: const FaIcon(FontAwesomeIcons.pause),
                      ),
                      const SizedBox(width: 30),
                      SizedBox(
                        child: _speech.isListening
                            ? const Text("Recording...",
                                style: TextStyle(color: Colors.green))
                            : const Text(
                                "Not recording...",
                                style: TextStyle(color: Colors.red),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent[100],
                      ),
                      // Within the `FirstRoute` widget
                      onPressed: () async {
                        if (key.currentState!.validate()) {
                          String categoryLabel = title.text;

                          Map<String, String> dataToSend = {
                            'title': categoryLabel,
                            'image': imageUrl,
                          };
                          //add a category (label + image) to firestore
                          _reference.add(dataToSend);

                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'SAVE CHANGES',
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
      ),
    );
  }
}
