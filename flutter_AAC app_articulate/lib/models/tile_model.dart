//Afiqah SUKD1802300
//Models for category and tiles 


// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class SpeechTilesModel {
  String id;
  String title_en;
  String title_ms;
  String? imageUrl;
  List<Tiles>? tiles;
  // int tilesCount;

  SpeechTilesModel({
    required this.id,
    required this.title_en,
    required this.title_ms,
    this.imageUrl,
    this.tiles,
  });

  SpeechTilesModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title_en = json['title-en'] as String,
        title_ms = json['title-ms'] as String,
        imageUrl = json['image_url'] as String,
        // tilesCount = 0,
        tiles = (json['tiles'] as List)
            .map((dynamic e) => Tiles.fromJson(e as Map<String, dynamic>))
            .toList();

  SpeechTilesModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        title_en = json['title-en'],
        title_ms = json['title-ms'],
        imageUrl = json['image_url'],
        // tilesCount = json['tiles_count'] as int,
        tiles = [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title-en'] = this.title_en;
    data['title-ms'] = this.title_ms;
    data['image_url'] = this.imageUrl;

    return data;
  }
}

class Tiles {
  String id;
  String label_en;
  String label_ms;
  String? imageUrl;

  Tiles(
      {required this.id,
      required this.label_en,
      required this.label_ms,
      this.imageUrl});

  Tiles.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        label_en = json['label-en'] as String,
        label_ms = json['label-ms'] as String,
        imageUrl = json['image_url'] as String;

  Tiles.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        label_en = snapshot['label-en'] as String,
        label_ms = snapshot['label-ms'] as String,
        imageUrl = snapshot['image_url'] as String?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label-en'] = this.label_en;
    data['label-ms'] = this.label_ms;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
