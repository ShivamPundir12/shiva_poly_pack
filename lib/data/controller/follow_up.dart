import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowUp extends GetxController {
  // Define sorting options
  RxString selectedOption = 'A-Z'.obs;

  // Method to display bottom sheet
  Future<void> selectOption(BuildContext context) async {
    if (selectedOption.value == 'A-Z') {
      selectedOption.value = 'Z-A';
      update();
    } else {
      selectedOption.value = 'A-Z';
      update();
    }
  }
}
