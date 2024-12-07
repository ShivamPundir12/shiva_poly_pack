import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageController extends GetxController {
  RxString imagePath = ''.obs;

  /// Initialize the controller with the given image path
  void setImagePath(String path) {
    imagePath.value = path;
  }

  /// Placeholder function to handle the image upload
  
}
