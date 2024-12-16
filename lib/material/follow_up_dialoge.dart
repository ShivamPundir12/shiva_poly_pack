import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/follow_up.dart';
import 'package:shiva_poly_pack/data/model/tag_list.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';

class FollowupDialog {
  static void showFollowUpDialog(BuildContext context) {
    final FollowUp controller = Get.find<FollowUp>();
    ResponsiveUI _ui = ResponsiveUI(context);

    Get.dialog(
      AlertDialog(
        title: Text(
          'Add Next FollowUp',
          style: Styles.getstyle(
            fontweight: FontWeight.bold,
            fontsize: _ui.widthPercent(5),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Follow-up Date Field
              Text(
                'Follow up Date',
                style: Styles.getstyle(
                  fontweight: FontWeight.w500,
                  fontsize: _ui.widthPercent(4),
                ),
              ),
              TextFormField(
                controller: controller.followUpDateController,
                decoration: InputDecoration(
                  hintText: 'Enter date',
                  hintStyle: Styles.getstyle(
                    fontcolor: ColorPallets.fadegrey.withOpacity(0.4),
                  ),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Review Field
              Text(
                'Review',
                style: Styles.getstyle(
                  fontweight: FontWeight.w500,
                  fontsize: _ui.widthPercent(4),
                ),
              ),
              TextFormField(
                controller: controller.reviewController,
                decoration: InputDecoration(
                  hintText: 'Say it..',
                  hintStyle: Styles.getstyle(
                    fontcolor: ColorPallets.fadegrey.withOpacity(0.4),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorPallets.themeColor2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              // Dropdown for Tags
              Text(
                'Select Status',
                style: Styles.getstyle(
                  fontweight: FontWeight.w500,
                  fontsize: _ui.widthPercent(4),
                ),
              ),
              FutureBuilder<TagListResponse>(
                  future: controller.getTagListData(),
                  builder: (context, snapshot) {
                    return Obx(
                      () => DropdownButtonFormField<int>(
                        value: controller.selectedTagId.value == 0
                            ? null
                            : controller.selectedTagId
                                .value, // Default null if nothing selected
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 10,
                          ),
                        ),
                        items: controller.tagList.map((Tag tag) {
                          return DropdownMenuItem<int>(
                            value: tag.id, // Store tag's ID as value
                            child: Text(tag.name), // Display tag's name
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          if (newValue != null) {
                            controller.onTagSelected(newValue);
                          }
                        },
                        hint: Text(
                          'Select a tag',
                          style: TextStyle(
                            color: Colors.grey.withOpacity(0.6),
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Close',
              style: Styles.getstyle(
                  fontweight: FontWeight.w600, fontcolor: Colors.red),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorPallets.themeColor,
            ),
            onPressed: () {
              controller.saveFollowUp();
            },
            child: Text(
              'Save',
              style: Styles.getstyle(
                fontweight: FontWeight.w600,
                fontcolor: ColorPallets.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
