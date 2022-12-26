//Afiqah SUKD1802300
//Function to upload JSON files to Firestore

import 'dart:convert';

import 'package:articulate/firebase_refs/loading_status.dart';
import 'package:articulate/firebase_refs/references.dart';
import 'package:articulate/models/tile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;

  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading; //0
    final fireStore = FirebaseFirestore.instance;

    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");

    //loads the json files
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final tilesInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/tiles/") && path.contains(".json"))
        .toList();

    List<SpeechTilesModel> categories = [];
    for (var category in tilesInAssets) {
      String stringTilesContent = await rootBundle.loadString(category);
      categories
          .add(SpeechTilesModel.fromJson(json.decode(stringTilesContent)));
    }
    // print('Category: ${categories[0].title}');
    var batch = fireStore.batch();

    for (var category in categories) {
      batch.set(categoryRF.doc(category.id), {
        "title-en": category.title_en,
        "title-ms": category.title_ms,
        "image_url": category.imageUrl
      });

      for (var tiles in category.tiles!) {
        final tilePath = tileRF(categoryID: category.id, tileID: tiles.id);
        batch.set(tilePath, {
          "label-en": tiles.label_en,
          "label-ms": tiles.label_ms,
          "image_url": tiles.imageUrl,
        });
      }
    }
    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;
  }
}
