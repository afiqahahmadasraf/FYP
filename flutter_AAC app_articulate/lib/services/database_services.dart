//Afiqah SUKD1802300
//Create collections in firestore

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('main_user_collection');

      final db =FirebaseFirestore.instance;

  Future createUserData(String activeUser) async {
    return await _reference.doc(uid).set({'activeUser': activeUser});
  }

  Future createTiles(String title, String image) async {
    return await _reference
        .doc(uid)
        .collection("user_tiles")
        .doc()
        .set({'title': title, 'image': image});
  }

  //   Future createTiles(String title, String image) async {
  //   return await _reference
  //       .doc(uid)
  //       .collection("user_category")
  //       .doc().collection("user_tiles").doc().set({'title': title, 'image': image});
  // }

}
