import 'package:get/get.dart';

class DatabaseController extends GetxController {
  String uploadedFileLink = '';
  String uploadedFilePath = '';

  RxBool isFileUploaded = false.obs;
}
