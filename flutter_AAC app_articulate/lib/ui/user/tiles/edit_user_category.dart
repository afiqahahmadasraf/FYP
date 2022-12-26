// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:articulate/ui/user/tiles/user_tiles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditTiles extends StatelessWidget {
  EditTiles(this.tile, {Key? key}) {
    _controllerName = TextEditingController(text: tile['title']);

    _reference = FirebaseFirestore.instance
        .collection('main_user_collection')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("user_tiles")
        .doc(tile['id']);
  }

  Map tile;
  late DocumentReference _reference;
  late TextEditingController _controllerName;
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Form(
            key: _key,
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
                  "Edit Tile",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(fontSize: 18),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _controllerName,
                  decoration: const InputDecoration(
                      hintText: 'Enter the name for the tile'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the tile name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 40,
                  width: 180,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent[100],
                    ),
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        String name = _controllerName.text;

                        //Create the Map of data
                        Map<String, String> dataToUpdate = {
                          'title': name,
                        };
                        //Call update()
                        _reference.update(dataToUpdate);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserTiles()),
                        );
                      }
                    },
                    child: Text(
                      'SAVE CHANGES',
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontSize: 14,
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
