//Afiqah SUKD1802300
//UI for home screen in malay

// ignore_for_file: avoid_print

import 'package:articulate/ui/audio/audio_player.dart';
import 'package:articulate/ui/game/main_game_screen.dart';
import 'package:articulate/ui/home/home_screen.dart';
import 'package:articulate/ui/home/tile_screen_ms.dart';
import 'package:articulate/ui/menu/about.dart';
import 'package:articulate/ui/menu/account.dart';
import 'package:articulate/ui/tts/tts_screen.dart';
import 'package:articulate/ui/user/tiles/user_tiles.dart';
import 'package:articulate/widgets/loading_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenMs extends StatefulWidget {
  const HomeScreenMs({Key? key}) : super(key: key);

  @override
  State<HomeScreenMs> createState() => _HomeScreenMsState();
}

class _HomeScreenMsState extends State<HomeScreenMs> {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('categories');

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final _colours = [
    Colors.green.shade200,
    Colors.purple.shade200,
    Colors.yellow.shade200,
    Colors.red.shade200,
    Colors.blue.shade200,
    Colors.orange.shade200,
    Colors.indigo.shade200,
    Colors.pink.shade200
  ];

  late List<QueryDocumentSnapshot> documents;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      //side menu contents
      drawer: Drawer(
        backgroundColor: Colors.blue[100],
        //Side menu bar
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            SafeArea(
              child: ListTile(
                leading: const FaIcon(FontAwesomeIcons.userAstronaut,
                    color: Colors.black),
                title: const Text('Account'),
                shape: ContinuousRectangleBorder(
                  side: const BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ManageAccount()),
                  );
                },
              ),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.solidCircleQuestion,
                  color: Colors.black),
              title: const Text('About Articulate'),
              shape: ContinuousRectangleBorder(
                side: const BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AboutArticulate()),
                );
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        //call the categories
        stream: _reference.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text('An error has occurred ${snapshot.error}'));
          }
          //display tile images
          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data;
            documents = querySnapshot.docs;

            List<Map> categories = documents
                .map((e) => {
                      'id': e.id,
                      'title-en': e['title-en'],
                      'title-ms': e['title-ms'],
                      'image_url': e['image_url']
                    })
                .toList();
            //end of calling the categories
            //ui for home screen
            return SafeArea(
                child: Container(
              color: Colors.lightBlue[50],
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          const snackBar =
                              SnackBar(content: Text('Tekan sebentar!'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        onLongPress: () {
                          _key.currentState?.openDrawer();
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
                                      Icons.list,
                                      size: 35,
                                    ), // <-- Icon
                                    Text("Menu"), // <-- Text
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueAccent[100],
                          ),
                          onPressed: () async {
                            const snackBar = SnackBar(
                                content:
                                    Text('Bahasa semasa adalah Bahasa Melayu'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: Text(
                            'BM',
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 40,
                        width: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueAccent[100],
                          ),
                          onPressed: () async {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                            );
                          },
                          child: Text(
                            'ENG',
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox.fromSize(
                        size: const Size(68, 68),
                        child: ClipOval(
                          child: Material(
                            color: Colors.lightBlue.shade100,
                            child: InkWell(
                              splashColor: Colors.blue.shade200,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Levels()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(
                                    Icons.videogame_asset,
                                    color: Colors.red,
                                    size: 35,
                                  ), // <-- Icon
                                  Text(
                                    "Permainan",
                                    style: TextStyle(fontSize: 10),
                                  ), // <-- Text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox.fromSize(
                        size: const Size(68, 68),
                        child: ClipOval(
                          child: Material(
                            color: Colors.lightBlue.shade100,
                            child: InkWell(
                              splashColor: Colors.blue.shade200,
                              onTap: () {
                                const snackBar =
                                    SnackBar(content: Text('Tekan sebentar!'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              onLongPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AudioPlayer()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(
                                    Icons.audio_file,
                                    color: Colors.purple,
                                    size: 35,
                                  ), // <-- Icon
                                  Text("Lagu"), // <-- Text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox.fromSize(
                        size: const Size(68, 68),
                        child: ClipOval(
                          child: Material(
                            color: Colors.lightBlue.shade100,
                            child: InkWell(
                              splashColor: Colors.blue.shade200,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TextToSpeech()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(
                                    Icons.keyboard_alt_sharp,
                                    color: Colors.blue,
                                    size: 35,
                                  ), // <-- Icon
                                  Text(
                                    "Bertutur",
                                    style: TextStyle(fontSize: 13),
                                  ), // <-- Text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox.fromSize(
                        size: const Size(68, 68),
                        child: ClipOval(
                          child: Material(
                            color: Colors.lightBlue.shade100,
                            child: InkWell(
                              splashColor: Colors.blue.shade200,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UserTiles()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(
                                    Icons.grid_view,
                                    color: Colors.green,
                                    size: 35,
                                  ), // <-- Icon
                                  Text("Butang"), // <-- Text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: ReorderableListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map thisCategory = categories[index];
                        return Padding(
                          key: ValueKey(thisCategory),
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ColoredBox(
                              color: _colours[index % _colours.length],
                              child: ListTile(
                                title: Text('${thisCategory['title-ms']}',
                                    style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(fontSize: 18),
                                      fontWeight: FontWeight.w500,
                                    )),
                                leading: SizedBox(
                                  height: Get.width * 0.2,
                                  width: Get.width * 0.2,
                                  child: thisCategory.containsKey('image_url')
                                      ? Image.network(
                                          '${thisCategory['image_url']}',
                                          width: 50,
                                          height: 50)
                                      : Image.asset("assets/img/logo.png"),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          TilesScreenMs(thisCategory['id'])));
                                  print(thisCategory['id']);
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      onReorder: (int oldIndex, int newIndex) {
                        if (newIndex > oldIndex) newIndex -= 1;

                        final item = categories.removeAt(oldIndex);
                        categories.insert(newIndex, item);
                      },
                    ),
                  )
                ],
              ),
            ));
          } //end display tile images
          //Show loader
          return const Center(child: Loading());
        },
      ), //Display a list // Add a FutureBuilder
    );
  }
}
