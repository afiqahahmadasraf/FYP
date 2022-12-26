//Afiqah SUKD1802300
//Instances and references to fetch data from Firestore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final fireStore = FirebaseFirestore.instance;
Reference get firebaseStorage => FirebaseStorage.instance.ref();

//create user collection in Firestore
final userRF = fireStore.collection("users");

//create category collection in Firestore
final categoryRF = fireStore.collection('categories');

//create category collection in Firestore
final userCategoryRF = fireStore.collection('user_categories');

//create tiles collection in Firestore
DocumentReference tileRF({
  required String categoryID,
  required String tileID,
}) =>
    categoryRF.doc(categoryID).collection("tiles").doc(tileID);
