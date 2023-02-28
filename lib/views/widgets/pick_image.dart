import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qoutes_app/controllers/database_controller.dart';
import 'package:qoutes_app/services/storage_service.dart';

import 'package:qoutes_app/views/styles.dart';

class PickAndUploadImage extends StatelessWidget {
  PickAndUploadImage({Key? key, required this.firebasePath}) : super(key: key);
  final String firebasePath;
  final StorageService storageService = StorageService();
  FilePickerResult? pickedFile;
  final DatabaseController databaseController =
      Get.find(tag: 'databaseController');
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () async => {
          if ((await requestLocalStoragePermission(
                  'Please Allow to pick the image')) ==
              PermissionStatus.granted)
            {
              pickedFile = await FilePicker.platform.pickFiles(
                type: FileType.image,
              ),
              if (pickedFile != null)
                {
                  await storageService.uploadFile(
                      File(pickedFile!.files.single.path ?? ""), firebasePath),
                }
            }
        },
        // ? Row(
        //           children: [
        //             CircleAvatar(
        //               radius: 80,
        //               backgroundImage:
        //                   NetworkImage(databaseController.uploadedFileLink),
        //             ),
        //           ],
        //         )
        //       : Image.asset("assets/signup.png"),
        child: databaseController.isFileUploaded.value
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        NetworkImage(databaseController.uploadedFileLink),
                  ),
                  IconButton(
                    onPressed: () async => {
                      storageService.deleteRecentUploadedFile(),
                      pickedFile = null,
                    },
                    icon: const Icon(
                      Icons.close_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ],
              )
            : Image.asset("assets/signup.png"),
      ),
    );
  }
}

Future<PermissionStatus> requestLocalStoragePermission(
    String requestReason) async {
  PermissionStatus status;

  if ((await Permission.storage.isPermanentlyDenied) ||
      (await Permission.storage.isDenied)) {
    status = PermissionStatus.denied;
    Get.dialog(AlertDialog(
      title: Text(
        "storagePermissionRequired".tr,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      content: Text(
        requestReason,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Center(
            child: TextButton(
                onPressed: () async => {
                      await openAppSettings(),
                      Get.back() //close dialog
                    },
                child: Text("grantPermission".tr)))
      ],
    ));
  } else {
    try {
      status = await Permission.storage.request();
    } catch (err) {
      status = PermissionStatus.denied;
    }
  }
  return status;
}
