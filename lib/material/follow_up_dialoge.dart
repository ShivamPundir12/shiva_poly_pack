import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/follow_up.dart';
import 'package:shiva_poly_pack/data/model/follow_up.dart';
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
                onTap: () => controller.selectDate(context),
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.calendar_month,
                    color: ColorPallets.fadegrey2,
                  ),
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
            onPressed: () => controller.clearController(),
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

class FollowUpListDialog extends StatelessWidget {
  final List<PostedFollowUp> followUpData;
  final String name;

  const FollowUpListDialog(
      {Key? key, required this.followUpData, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1),

          // List of Follow-up Data
          SizedBox(
            height: 300, // Adjust height for scrollability
            child: ListView.builder(
              itemCount: followUpData.length,
              itemBuilder: (context, index) {
                final data = followUpData[index];
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.calendar_today, color: Colors.blue),
                      title: Text(
                        "Follow Up Date: ${data.followupDate}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "Review: ${data.review}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: Chip(
                        label: Text('Tag 1'),
                        backgroundColor: Colors.blue.shade100,
                      ),
                    ),
                    const Divider(height: 1),
                  ],
                );
              },
            ),
          ),

          // Close Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Close",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
