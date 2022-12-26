//Afiqah SUKD1802300
//UI for data uploading function

// ignore_for_file: must_be_immutable

import 'package:articulate/jsonToFirestore/data_uploader.dart';
import 'package:articulate/firebase_refs/loading_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataUploaderScreen extends StatelessWidget {
  DataUploaderScreen({Key? key}) : super(key: key);
  DataUploader controller = Get.put(DataUploader());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Obx(() => Text(
          controller.loadingStatus.value == LoadingStatus.completed
              ? "Uploading Completed!"
              : "Uploading...")),
    ));
  }
}
