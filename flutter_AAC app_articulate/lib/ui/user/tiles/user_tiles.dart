// ignore_for_file: avoid_print

import 'package:articulate/ui/user/tiles/create_tile.dart';
import 'package:articulate/ui/user/tiles/user_tiles_details.dart';
import 'package:articulate/widgets/loading_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTiles extends StatefulWidget {
  const UserTiles({super.key});

  @override
  State<UserTiles> createState() => _UserTilesState();
}

class _UserTilesState extends State<UserTiles> {
  FlutterTts tts = FlutterTts();
  List<String>? languages;
  String langCode = "en-UK";

  Future _speak(String text) async {
    await tts.speak(text);
    await tts.setLanguage("en-UK");
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
    getUsers();
  }

  void init() async {
    languages = List<String>.from(await tts.getLanguages);
    setState(() {});
  }

  void initSetting() async {
    await tts.setLanguage(langCode);
  }

  final CollectionReference _reference = FirebaseFirestore.instance
      .collection('main_user_collection')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("user_tiles");

  final ref = FirebaseFirestore.instance.collection("main_user_collection");

  getUsers() {
    ref.get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        print(doc.data());
      }
    });
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

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
      key: _key,
      body: useMobileLayout
          ? buildPhoneLayout(orientation: orientation)
          : buildTabletLayout(orientation: orientation),
    );
  }

  Widget buildPhoneLayout({required Orientation orientation}) {
    return StreamBuilder<QuerySnapshot>(
      stream: _reference.snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('An error has occurred ${snapshot.error}'));
        }
        if (snapshot.hasData) {
          QuerySnapshot querySnapshot = snapshot.data;
          List<QueryDocumentSnapshot> documents = querySnapshot.docs;
          List<Map> categories = documents
              .map(
                  (e) => {'id': e.id, 'title': e['title'], 'image': e['image']})
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
                  Text(
                    "Your Tiles",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(fontSize: 18),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            const snackBar = SnackBar(
                                content: Text('Press down to access!'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          onLongPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CreateTiles()),
                            );
                          },
                          child: SizedBox.fromSize(
                            size: const Size(68, 68),
                            child: ClipOval(
                              child: Material(
                                color: Colors.lightBlue.shade100,
                                child: InkWell(
                                  splashColor: Colors.blue.shade200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const <Widget>[
                                      Icon(
                                        Icons.add,
                                        size: 35,
                                      ), // <-- Icon
                                      Text("Add"), // <-- Text
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              orientation == Orientation.portrait ? 2 : 3,
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 20.0,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map thisTile = categories[index];
                          return InkWell(
                            onTap: () {
                              _speak('${thisTile['title']}');
                            },
                            onLongPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ItemDetails(thisTile['id'])));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ColoredBox(
                                  color: _colours[index % _colours.length],
                                  child: GridTile(
                                    footer: Text(
                                      '${thisTile['title']}',
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
                                          child: thisTile.containsKey('image')
                                              ? Image.network(
                                                  '${thisTile['image']}',
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
    return StreamBuilder<QuerySnapshot>(
      stream: _reference.snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('An error has occurred ${snapshot.error}'));
        }
        if (snapshot.hasData) {
          QuerySnapshot querySnapshot = snapshot.data;
          List<QueryDocumentSnapshot> documents = querySnapshot.docs;
          List<Map> categories = documents
              .map(
                  (e) => {'id': e.id, 'title': e['title'], 'image': e['image']})
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
                  Text(
                    "Your Tiles",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(fontSize: 18),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            const snackBar = SnackBar(
                                content: Text('Press down to access!'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          onLongPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CreateTiles()),
                            );
                          },
                          child: SizedBox.fromSize(
                            size: const Size(68, 68),
                            child: ClipOval(
                              child: Material(
                                color: Colors.lightBlue.shade100,
                                child: InkWell(
                                  splashColor: Colors.blue.shade200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const <Widget>[
                                      Icon(
                                        Icons.add,
                                        size: 35,
                                      ), // <-- Icon
                                      Text("Add"), // <-- Text
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              orientation == Orientation.portrait ? 3 : 4,
                          crossAxisSpacing: 15.0,
                          mainAxisSpacing: 15.0,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map thisTile = categories[index];
                          return InkWell(
                            onTap: () {
                              _speak('${thisTile['title']}');
                            },
                            onLongPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ItemDetails(thisTile['id'])));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ColoredBox(
                                  color: _colours[index % _colours.length],
                                  child: GridTile(
                                    footer: Text(
                                      '${thisTile['title']}',
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
                                          height: Get.width * 0.20,
                                          width: Get.width * 0.25,
                                          child: thisTile.containsKey('image')
                                              ? Image.network(
                                                  '${thisTile['image']}',
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
