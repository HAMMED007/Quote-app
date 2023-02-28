import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:qoutes_app/views/styles.dart';

customLoadingDialog() {
  //display a get loading popup before reading
  Get.dialog(
    const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    ),
    barrierDismissible: false,
  );
}

void generateError(String title, String message) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    colorText: Colors.black,
    icon: const Icon(
      Icons.error_outline,
      color: Colors.red,
    ),
    margin: const EdgeInsets.all(10),
    duration: const Duration(seconds: 2),
  );
}

void generateMessage(String title, String message) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    colorText: Colors.black,
    icon: const Icon(Icons.message, color: Colors.black),
    margin: const EdgeInsets.all(10),
    duration: const Duration(seconds: 3),
  );
}
