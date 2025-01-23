import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/follow_up.dart';
import 'package:shiva_poly_pack/data/model/follow_up.dart';
import 'package:shiva_poly_pack/data/model/tag_list.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';

class FollowupDialog {
  static void showFollowUpDialog(
    BuildContext context,
    String crmId,
  ) {
    final FollowUp controller = Get.find<FollowUp>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Next FollowUp',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                // Follow-up Date Field
                Text('Follow up Date'),
                TextFormField(
                  controller: controller.followUpDateController,
                  onTap: () {
                    FocusScope.of(context).unfocus(); // Dismiss keyboard
                    controller.selectDate(context);
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.calendar_today),
                    hintText: 'Enter date',
                  ),
                ),
                const SizedBox(height: 16),
                // Review Field
                Text('Review'),
                TextFormField(
                  controller: controller.reviewController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Say it...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                // Dropdown for Status
                Text('Select Status'),
                Obx(() => DropdownButtonFormField<int>(
                      value: controller.selectedTagId.value == 0
                          ? null
                          : controller.selectedTagId.value,
                      items: controller.tagList.map((tag) {
                        return DropdownMenuItem<int>(
                          value: tag.id,
                          child: Text(tag.name),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        if (newValue != null) {
                          controller.onTagSelected(newValue);
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    )),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        controller.clearController();
                        Get.back();
                      },
                      child: Text('Close', style: TextStyle(color: Colors.red)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.saveFollowUp(crmId);
                      },
                      child: Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FollowUpListScreen extends GetView<FollowUp> {
  final String name;

  const FollowUpListScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name.capitalize.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Get.back(canPop: true),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1),
          // List of Follow-up Data
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.postfollowUpList.length,
                itemBuilder: (context, index) {
                  final data = controller.postfollowUpList[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.calendar_today,
                          color: ColorPallets.themeColor,
                          size: 22,
                        ),
                        title: Text(
                          "Follow Up Date: ${controller.formatDate(data.followupDate.toIso8601String())}",
                          style:
                              Styles.getstyle(fontsize: _ui.widthPercent(3.4)),
                        ),
                        subtitle: data.review.isEmpty
                            ? Text(
                                "Review: No review",
                                style: const TextStyle(color: Colors.grey),
                              )
                            : Text(
                                "Review: ${data.review}",
                                overflow: TextOverflow.visible,
                                style: const TextStyle(color: Colors.grey),
                              ),
                        trailing: data.tagsName.isEmpty
                            ? Text(
                                "No tags",
                                style: TextStyle(
                                  color: ColorPallets.fadegrey2,
                                  fontSize: _ui.widthPercent(3.4),
                                ),
                              )
                            : Container(
                                // width: 200, // Adjust width if necessary
                                child: data.tagsName.length > 2
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          // Show the first two tags
                                          Flexible(
                                            child: Wrap(
                                              // spacing: 4.0,
                                              children: data.tagsName
                                                  .sublist(0, 2)
                                                  .asMap()
                                                  .entries
                                                  .map<Widget>(
                                                (entry) {
                                                  final index = entry.key;
                                                  final item = entry.value;
                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        height: 30,
                                                        child: Text(
                                                          textAlign:
                                                              TextAlign.end,
                                                          item.toString(),
                                                          style:
                                                              Styles.getstyle(
                                                            fontcolor:
                                                                ColorPallets
                                                                    .themeColor,
                                                            fontweight:
                                                                FontWeight.w400,
                                                            fontsize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                      if (index !=
                                                          1) // Add a comma only after the first item
                                                        Text(
                                                          ',',
                                                          style:
                                                              Styles.getstyle(
                                                            fontcolor:
                                                                ColorPallets
                                                                    .fadegrey2,
                                                            fontweight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                    ],
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // Show dialog or bottom sheet with all tags
                                              Get.dialog(
                                                AlertDialog(
                                                  title: Text('Tags'),
                                                  content: Wrap(
                                                    spacing: 4.0,
                                                    runSpacing: 4.0,
                                                    children: data.tagsName
                                                        .map<Widget>((item) {
                                                      return Chip(
                                                        label: Text(
                                                          item.toString(),
                                                          style:
                                                              Styles.getstyle(
                                                            fontcolor:
                                                                ColorPallets
                                                                    .themeColor,
                                                            fontweight:
                                                                FontWeight.w400,
                                                            fontsize: 14,
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Get.back(),
                                                      child: Text(
                                                        'Close',
                                                        style: Styles.getstyle(
                                                          fontcolor:
                                                              ColorPallets
                                                                  .themeColor,
                                                          fontweight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            child: Text(
                                              ' ...',
                                              style: Styles.getstyle(
                                                fontcolor:
                                                    ColorPallets.fadegrey2,
                                                fontweight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Wrap(
                                        spacing: 4.0,
                                        children: data.tagsName
                                            .asMap()
                                            .entries
                                            .map<Widget>(
                                          (entry) {
                                            final index = entry.key;
                                            final item = entry.value;
                                            return Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  item.toString(),
                                                  style: Styles.getstyle(
                                                    fontcolor:
                                                        ColorPallets.themeColor,
                                                    fontweight: FontWeight.w400,
                                                    fontsize: 14,
                                                  ),
                                                ),
                                                if (index !=
                                                    data.tagsName.length - 1)
                                                  Text(
                                                    ', ',
                                                    style: Styles.getstyle(
                                                      fontcolor: ColorPallets
                                                          .fadegrey2,
                                                      fontweight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                              ],
                                            );
                                          },
                                        ).toList(),
                                      ),
                              ),
                      ),
                      const Divider(height: 1),
                    ],
                  );
                },
              ),
            ),
          ),
          Obx(() {
            if (controller.postfollowUpList.isNotEmpty &&
                controller.post_followUp_total_pages.value > 1) {
              // Pagination controls
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: () {
                      if (controller.post_followUp_current_page.value > 1) {
                        controller.prevPage(false);
                      }
                    },
                  ),
                  Obx(() => Text(controller.post_followUp_current_page.value
                          .toString() +
                      " of " +
                      controller.post_followUp_total_pages.value.toString())),
                  IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: () {
                      print('Length : ${controller.postfollowUpList.length}');
                      if (!controller.isLastPage.value) {
                        controller.nextPage(false);
                      }
                    },
                  ),
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}
