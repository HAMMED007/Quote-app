import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qoutes_app/controllers/database_controller.dart';
import 'package:qoutes_app/views/styles.dart';
import 'package:path/path.dart' as path;
import 'package:qoutes_app/views/widgets/customSnackbar.dart';

class StorageService {
  final storageRef = FirebaseStorage.instance.ref();
  DatabaseController databaseController = Get.find(tag: 'databaseController');

  uploadFile(File file, String firbasePath) async {
    String fileName = path.basename(file.path);
    databaseController.isFileUploaded.value = false;
    databaseController.uploadedFileLink = "";
    databaseController.uploadedFilePath = '$firbasePath/$fileName';
    var snapshot = storageRef.child('$firbasePath/$fileName');
    try {
      customLoadingDialog();
      snapshot.putFile(file).snapshotEvents.listen((taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            // ...
            break;
          case TaskState.paused:
            // ...
            break;
          case TaskState.success:
            var downloadUrl = await snapshot.getDownloadURL();
            databaseController.isFileUploaded.value = true;
            databaseController.uploadedFileLink = downloadUrl;
            Get.back(); //popup-dialog remove

            break;
          case TaskState.canceled:
            Get.back(); //popup-dialog remove
            generateError("Image Not uploaded", "Please try again ");
            break;
          case TaskState.error:
            Get.back(); //popup-dialog remove
            generateError("Image Not uploaded", "Please try again ");

            break;
        }
      });
    } on FirebaseException catch (e) {
      // Get.back(); //popup-dialog remove
      rethrow;
    }
  }

  Future<void> deleteFileFromURL(String url) async {
    try {
      FirebaseStorage.instance.refFromURL(url).delete();
    } catch (e) {}
  }

  deleteRecentUploadedFile() async {
    await storageRef.child(databaseController.uploadedFilePath).delete();
    databaseController.isFileUploaded.value = false;
    databaseController.uploadedFileLink = "";
    databaseController.uploadedFilePath = "";
  }
}
