import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/styles.dart';

class FollowUp extends GetxController {
  // Define sorting options
  RxString selectedOption = 'A-Z'.obs;

  // Method to display bottom sheet
  Future<void> selectOption(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (b) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header for bottom sheet
            ListTile(
              title: Text(
                "Sort by",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // Option A-Z
            Obx(() => RadioListTile<String>(
                  enableFeedback: true,
                  title: Text(
                    "A-Z",
                    style: Styles.getstyle(
                        fontweight: FontWeight.bold, fontsize: 20),
                  ),
                  value: "A-Z",
                  groupValue: selectedOption.value,
                  activeColor: ColorPallets.themeColor,
                  onChanged: (value) {
                    if (value != null) {
                      selectedOption.value = value;
                      Navigator.pop(context); // Close the bottom sheet
                    }
                  },
                )),
            // Option Z-A
            Obx(() => RadioListTile<String>(
                  enableFeedback: true,
                  title: Text(
                    "Z-A",
                    style: Styles.getstyle(
                        fontweight: FontWeight.bold, fontsize: 20),
                  ),
                  value: "Z-A",
                  activeColor: ColorPallets.themeColor,
                  groupValue: selectedOption.value,
                  onChanged: (value) {
                    if (value != null) {
                      selectedOption.value = value;
                      Navigator.pop(context); // Close the bottom sheet
                    }
                  },
                )),
          ],
        );
      },
    );
  }
}
