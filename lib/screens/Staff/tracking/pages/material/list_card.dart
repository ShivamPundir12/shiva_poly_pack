import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/crm_list.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';

import '../../../../../data/model/tag_list.dart';
import '../../../../../material/follow_up_dialoge.dart';

class CustomerCard extends GetView<CRMListController> {
  final int index;

  const CustomerCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final customer = controller.customerList[index];
    ResponsiveUI _ui = ResponsiveUI(context);
    controller.getTagListData();
    return Card(
      color: customer.colour.isNotEmpty
          ? Color(
              int.parse(
                customer.colour[0].toString().replaceFirst('#', '0xFF'),
              ),
            )
          : Colors.white,
      margin: const EdgeInsets.all(8),
      elevation: 4,
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 150,
              child: Text(
                customer.name.capitalize.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showTagSelectionBottomSheet(
                      options: controller.tagList,
                      isBusiness: false,
                      onTagSelected: (p0) => controller.updateTag(
                          p0.toString(), customer.id.toString()),
                      selectedTags: controller.selectedTag.value,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(_ui.widthPercent(30), _ui.heightPercent(5)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    backgroundColor: ColorPallets.themeColor,
                  ),
                  child: Text(
                    'Add Tagging',
                    style: Styles.getstyle(
                      fontcolor: ColorPallets.white,
                      fontsize: _ui.widthPercent(3),
                      fontweight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: _ui.widthPercent(1)),
                InkWell(
                  radius: 200,
                  borderRadius: BorderRadius.circular(200),
                  onTap: () {
                    controller.fetchfollowUp(customer.id.toString());
                    Get.to(
                      FollowUpListScreen(name: customer.name),
                    );
                  },
                  child: Icon(
                    Icons.remove_red_eye_outlined,
                    color: ColorPallets.themeColor,
                  ),
                ),
              ],
            )
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildInfoRow(
                    "Phone Number",
                    customer.phoneNumber,
                    customer.fontColour.any((e) => e != null)
                        ? Color(
                            int.parse(
                              customer.fontColour[0]
                                  .toString()
                                  .replaceFirst('#', '0xFF'),
                            ),
                          )
                        : Colors.black),
                _buildInfoRow(
                    "Tags",
                    customer.tags,
                    customer.fontColour.any((e) => e != null)
                        ? Color(
                            int.parse(
                              customer.fontColour[0]
                                  .toString()
                                  .replaceFirst('#', '0xFF'),
                            ),
                          )
                        : Colors.black),
                _buildInfoRow(
                    "Location",
                    customer.location,
                    customer.fontColour.any((e) => e != null)
                        ? Color(
                            int.parse(
                              customer.fontColour[0]
                                  .toString()
                                  .replaceFirst('#', '0xFF'),
                            ),
                          )
                        : Colors.black),
                _buildInfoRow(
                    "Business Tag",
                    customer.businessTags,
                    customer.fontColour.any((e) => e != null)
                        ? Color(
                            int.parse(
                              customer.fontColour[0]
                                  .toString()
                                  .replaceFirst('#', '0xFF'),
                            ),
                          )
                        : Colors.black),
                _buildInfoRow(
                    "Last Comment",
                    customer.lastComment,
                    customer.fontColour.any((e) => e != null)
                        ? Color(
                            int.parse(
                              customer.fontColour[0]
                                  .toString()
                                  .replaceFirst('#', '0xFF'),
                            ),
                          )
                        : Colors.black),
                _buildInfoRow(
                    "Party Name",
                    customer.partyName,
                    customer.fontColour.any((e) => e != null)
                        ? Color(
                            int.parse(
                              customer.fontColour[0]
                                  .toString()
                                  .replaceFirst('#', '0xFF'),
                            ),
                          )
                        : Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to show the tagging bottom sheet
  void _showTagSelectionBottomSheet({
    required List<Tag> options,
    required bool isBusiness,
    required Function(int) onTagSelected,
    required Tag selectedTags,
  }) {
    bool isClosing = false; // Flag to prevent multiple taps

    Get.bottomSheet(
      Container(
        height: 300,
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Select a tag',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final tag = options[index];

                  return GestureDetector(
                    onTap: () {
                      if (!isClosing) {
                        isClosing = true;
                        Navigator.pop(context);
                        onTagSelected(tag.id);
                        controller.onTagNameSelected(tag);
                      }
                    },
                    child: ListTile(
                      tileColor: ColorPallets.fadegrey,
                      selectedColor: ColorPallets.fadegrey,
                      selectedTileColor: ColorPallets.fadegrey,
                      title: Text(
                        tag.name,
                        style: Styles.getstyle(fontweight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  // Helper method to build rows of information
  Widget _buildInfoRow(String label, Object? value, Color? fontcolor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Styles.getstyle(
              fontweight: FontWeight.w400,
              fontsize: 14,
              fontcolor: fontcolor,
            ),
          ),
          displayValue(value, fontcolor: fontcolor),
        ],
      ),
    );
  }

  Widget displayValue(dynamic value, {Color? fontcolor}) {
    if (value is List) {
      return Container(
        width: 200, // Adjust width if necessary
        child: value.length > 1
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Show the first two tags
                  Flexible(
                    child: Wrap(
                      // spacing: 4.0,
                      children: value.sublist(0, 2).asMap().entries.map<Widget>(
                        (entry) {
                          final index = entry.key;
                          final item = entry.value;
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                child: Text(
                                  textAlign: TextAlign.end,
                                  item.toString(),
                                  style: Styles.getstyle(
                                    fontcolor: fontcolor,
                                    fontweight: FontWeight.w400,
                                    fontsize: 14,
                                  ),
                                ),
                              ),
                              if (index !=
                                  1) // Add a comma only after the first item
                                Text(
                                  ',',
                                  style: Styles.getstyle(
                                    fontcolor: ColorPallets.fadegrey2,
                                    fontweight: FontWeight.w600,
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
                            children: value.map<Widget>((item) {
                              return Chip(
                                label: Text(
                                  item.toString(),
                                  style: Styles.getstyle(
                                    fontcolor: fontcolor,
                                    fontweight: FontWeight.w400,
                                    fontsize: 14,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: Text(
                                'Close',
                                style: Styles.getstyle(
                                  fontcolor: fontcolor,
                                  fontweight: FontWeight.w600,
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
                        fontcolor: ColorPallets.fadegrey2,
                        fontweight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            : Wrap(
                spacing: 4.0,
                children: value.asMap().entries.map<Widget>(
                  (entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item.toString(),
                          style: Styles.getstyle(
                            fontcolor: fontcolor,
                            fontweight: FontWeight.w400,
                            fontsize: 14,
                          ),
                        ),
                        if (index != value.length - 1)
                          Text(
                            ', ',
                            style: Styles.getstyle(
                              fontcolor: ColorPallets.fadegrey2,
                              fontweight: FontWeight.w600,
                            ),
                          ),
                      ],
                    );
                  },
                ).toList(),
              ),
      );
    } else if (value is String) {
      return Container(
        width: 200,
        height: 20,
        child: Text(
          value.capitalize.toString(),
          maxLines: null,
          overflow: TextOverflow.fade,
          softWrap: true,
          style: Styles.getstyle(
            fontweight: FontWeight.w600,
            fontcolor: fontcolor,
            fontsize: 14,
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
