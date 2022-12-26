// ignore_for_file: must_be_immutable

import 'package:articulate/ui/user/tiles/edit_user_category.dart';
import 'package:articulate/widgets/loading_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemDetails extends StatelessWidget {
  ItemDetails(this.itemId, {Key? key}) : super(key: key) {
    _reference = FirebaseFirestore.instance
        .collection('main_user_collection')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("user_tiles")
        .doc(itemId);

    _futureData = _reference.get();
  }

  String itemId;
  late DocumentReference _reference;
  late Future<DocumentSnapshot> _futureData;
  late Map data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            //Get the data
            DocumentSnapshot documentSnapshot = snapshot.data;
            data = documentSnapshot.data() as Map;

            //display the data
            return SafeArea(
                child: Container(
              color: Colors.lightBlue[50],
              child: Column(
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_rounded)),
                      ),
                    ],
                  ),
                  Text(
                    "Tile Details",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(fontSize: 18),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Edit the tile label or delete the tile",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(fontSize: 14),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ColoredBox(
                      color: Colors.blue.shade100,
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  //add the id to the map
                                  data['id'] = itemId;

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => EditTiles(data)));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                )),
                            IconButton(
                                onPressed: () {
                                  _reference.delete();
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      )),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Current Tile Image:",
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(fontSize: 16),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                      child: Image.network('${data['image']}',
                          width: 250, height: 250)),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Current Tile Label: ${data['title']}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(fontSize: 16),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ));
          }
          return const Center(child: Loading());
        },
      ),
    );
  }
}
