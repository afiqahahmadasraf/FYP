//Afiqah SUKD1802300
//UI for malay tiles screen

// ignore_for_file: must_be_immutable

import 'package:articulate/widgets/loading_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TilesScreenMs extends StatefulWidget {
  TilesScreenMs(this.tileID, {Key? key}) : super(key: key);

  String tileID;

  @override
  State<TilesScreenMs> createState() => _TilesScreenMsState();
}

class _TilesScreenMsState extends State<TilesScreenMs> {
  FlutterTts tts = FlutterTts();
  List<String>? languages;
  double speechRate = 0.5;
  String langCode = "ms-MY";

  Future _speak(String text) async {
    await tts.speak(text);
    await tts.setLanguage("ms-MY");
    await tts.setSpeechRate(0.3);
    initSetting();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    languages = List<String>.from(await tts.getLanguages);
    setState(() {});
  }

  void initSetting() async {
    await tts.setLanguage(langCode);
    await tts.setSpeechRate(speechRate);
  }

  final _colours = [
    Colors.pink.shade200,
    Colors.red.shade200,
    Colors.blue.shade200,
    Colors.green.shade200,
    Colors.purple.shade200,
    Colors.orange.shade200,
    Colors.indigo.shade200,
    Colors.yellow.shade200,
  ];

  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shortestSide < 600;
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: useMobileLayout
          ? buildPhoneLayout(orientation: orientation)
          : buildTabletLayout(orientation: orientation),
    );
  }

  Widget buildPhoneLayout({required Orientation orientation}) {
    final CollectionReference reference = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.tileID)
        .collection("tiles");

    return StreamBuilder<QuerySnapshot>(
      stream: reference.snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('An error has occurred ${snapshot.error}'));
        }
        if (snapshot.hasData) {
          QuerySnapshot querySnapshot = snapshot.data;
          List<QueryDocumentSnapshot> documents = querySnapshot.docs;

          List<Map> tiles = documents
              .map((e) => {
                    'id': e.id,
                    'label-en': e['label-en'],
                    'label-ms': e['label-ms'],
                    'image_url': e['image_url']
                  })
              .toList();
          return SafeArea(
            child: Container(
              color: Colors.lightBlue[50],
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
                      const Text("Pilihan Suara: "),
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
                      const SizedBox(width: 10),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Kelajuan Suara: "),
                      Slider(
                        min: 0.0,
                        max: 1.0,
                        value: speechRate,
                        onChanged: (value) {
                          setState(() {
                            speechRate = value;
                          });
                        },
                      )
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              orientation == Orientation.portrait ? 2 : 3,
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 20.0,
                        ),
                        itemCount: tiles.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map thisTile = tiles[index];
                          return InkWell(
                            onTap: () {
                              _speak('${thisTile['label-ms']}');
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ColoredBox(
                                  color: _colours[index % _colours.length],
                                  child: GridTile(
                                    footer: Text(
                                      '${thisTile['label-ms']}',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.openSans(
                                        textStyle:
                                            const TextStyle(fontSize: 18),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: Get.width * 0.25,
                                          width: Get.width * 0.25,
                                          child: thisTile
                                                  .containsKey('image_url')
                                              ? Image.network(
                                                  '${thisTile['image_url']}',
                                                  width: 10,
                                                  height: 10)
                                              : Image.asset(
                                                  "assets/img/logo.png"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        }
        //Show loader
        return const Center(child: Loading());
      },
    );
  }

  Widget buildTabletLayout({required Orientation orientation}) {
    final CollectionReference reference = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.tileID)
        .collection("tiles");
    return StreamBuilder<QuerySnapshot>(
      stream: reference.snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('An error has occurred ${snapshot.error}'));
        }
        if (snapshot.hasData) {
          QuerySnapshot querySnapshot = snapshot.data;
          List<QueryDocumentSnapshot> documents = querySnapshot.docs;

          List<Map> tiles = documents
              .map((e) => {
                    'id': e.id,
                    'label-en': e['label-en'],
                    'label-ms': e['label-ms'],
                    'image_url': e['image_url']
                  })
              .toList();
          return SafeArea(
            child: Container(
              color: Colors.lightBlue[50],
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
                      const Text("Pilihan Suara: "),
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
                      const SizedBox(width: 10),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Kelajuan Suara: "),
                      Slider(
                        min: 0.0,
                        max: 1.0,
                        value: speechRate,
                        onChanged: (value) {
                          setState(() {
                            speechRate = value;
                          });
                        },
                      )
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              orientation == Orientation.portrait ? 3 : 4,
                          crossAxisSpacing: 15.0,
                          mainAxisSpacing: 15.0,
                        ),
                        itemCount: tiles.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map thisTile = tiles[index];
                          return InkWell(
                            onTap: () {
                              _speak('${thisTile['label-ms']}');
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ColoredBox(
                                  color: _colours[index % _colours.length],
                                  child: GridTile(
                                    footer: Text(
                                      '${thisTile['label-ms']}',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.openSans(
                                        textStyle:
                                            const TextStyle(fontSize: 18),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: Get.width * 0.25,
                                          width: Get.width * 0.25,
                                          child: thisTile
                                                  .containsKey('image_url')
                                              ? Image.network(
                                                  '${thisTile['image_url']}',
                                                  width: 10,
                                                  height: 10)
                                              : Image.asset(
                                                  "assets/img/logo.png"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        }
        //Show loader
        return const Center(child: Loading());
      },
    );
  }
}
