import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shiva_poly_pack/data/controller/follow_up.dart';
import 'package:shiva_poly_pack/data/model/tag_list.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/follow_up_dialoge.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/pages/material/follow_up_card.dart';

import '../../../../data/model/follow_up.dart';

class FollowUpScreen extends GetView<FollowUp> {
  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    controller.getTagListData();

    return Scaffold(
      backgroundColor: ColorPallets.white,
      resizeToAvoidBottomInset: false,
      extendBody: false,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: ColorPallets.white,
        bottom: PreferredSize(
            preferredSize: Size(_ui.widthPercent(70), _ui.heightPercent(2)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: _ui.widthPercent(5)),
              child: Divider(
                color: Colors.grey.shade400,
                thickness: 2.3,
              ),
            )),
        centerTitle: true,
        title: Text(
          'Follow Ups',
          style: Styles.getstyle(
              fontweight: FontWeight.bold, fontsize: _ui.widthPercent(6)),
        ),
        leading: IconButton(
          padding: EdgeInsets.only(
            left: _ui.widthPercent(5),
          ),
          icon: Icon(
            Icons.arrow_back,
            color: ColorPallets.themeColor,
            size: _ui.widthPercent(7),
          ),
          onPressed: () {
            Get.back(canPop: true);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(left: _ui.widthPercent(2)),
                  alignment: Alignment.centerLeft,
                  width: _ui.widthPercent(40),
                  child: TextField(
                    onChanged: (value) {
                      if (value.isEmpty) {
                        controller.searchData(value);
                      } else {
                        controller.filterpostfollowUpList.clear();
                        controller.getApiData(1);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      fillColor: ColorPallets.themeColor,
                      focusColor: ColorPallets.themeColor,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sort by',
                      style: Styles.getstyle(
                          fontweight: FontWeight.w700,
                          fontsize: _ui.widthPercent(3.5),
                          fontcolor: ColorPallets.fadegrey),
                    ),
                    SizedBox(
                      width: _ui.widthPercent(2),
                    ),
                    Stack(
                      fit: StackFit.loose,
                      alignment: Alignment.center,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(14),
                          radius: _ui.widthPercent(1),
                          onTap: () => controller.selectOption(context),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.grey.shade400, width: 0.1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            color: ColorPallets.white,
                            child: Container(
                              width: _ui.widthPercent(30),
                              height: _ui.heightPercent(5),
                              decoration: ShapeDecoration(
                                color: ColorPallets.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: ColorPallets.fadegrey, width: 0.4),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Obx(
                                    () => Text(
                                      controller.selectedOption.toString(),
                                      style: Styles.getstyle(
                                          fontweight: FontWeight.bold,
                                          fontsize: _ui.widthPercent(6)),
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/sort.svg',
                                    height: _ui.heightPercent(2.8),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: _ui.widthPercent(0.3),
                          height: _ui.heightPercent(4),
                          color: ColorPallets.fadegrey,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 16.0),
            Obx(() {
              if (controller.filterpostfollowUpList.isNotEmpty) {
                if (controller.isloading.value) {
                  return ProgressIndicatorWidget(
                    color: ColorPallets.themeColor,
                  );
                } else {
                  return Obx(() {
                    return controller.filterpostfollowUpList.isEmpty
                        ? _noData(ui: _ui)
                        : Expanded(
                            child: ListView.builder(
                              itemCount:
                                  controller.filterpostfollowUpList.length,
                              itemBuilder: (context, index) {
                                final item =
                                    controller.filterpostfollowUpList[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: _ui.heightPercent(0.4),
                                  ),
                                  child: FollowUpCard(
                                    item: item,
                                    eyeonTap: () async {
                                      controller.getFollowUpData(
                                          id: item.id.toString());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FollowUpListScreen(
                                            name: item.name,
                                          ),
                                        ),
                                      );
                                    },
                                    onTap: () {
                                      FollowupDialog.showFollowUpDialog(
                                          context, item.id.toString());
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                  });
                }
              } else {
                return FutureBuilder<FollowUpResponse>(
                    future: controller.getApiData(controller.currentPage.value),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ProgressIndicatorWidget(
                          color: ColorPallets.themeColor,
                        );
                      } else {
                        return Obx(() {
                          return controller.followUpList.isEmpty
                              ? _noData(ui: _ui)
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: controller.followUpList.length,
                                    itemBuilder: (context, index) {
                                      final item =
                                          controller.followUpList[index];
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom: _ui.heightPercent(0.4),
                                        ),
                                        child: FollowUpCard(
                                          item: item,
                                          eyeonTap: () async {
                                            controller.getFollowUpData(
                                                id: item.id.toString());
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FollowUpListScreen(
                                                  name: item.name,
                                                ),
                                              ),
                                            );
                                          },
                                          onTap: () {
                                            FollowupDialog.showFollowUpDialog(
                                                context, item.id.toString());
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                );
                        });
                      }
                    });
              }
            }),
            Obx(() {
              if (controller.followUpList.isNotEmpty &&
                  controller.total_pages.value > 1) {
                // Pagination controls
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: () {
                        if (!controller.isLastPage.value) {
                          controller.prevPage(true);
                        }
                      },
                    ),
                    Obx(() => Text(controller.currentPage.value.toString() +
                        " of " +
                        controller.total_pages.value.toString())),
                    IconButton(
                      icon: Icon(Icons.chevron_right),
                      onPressed: () {
                        print('Length : ${controller.followUpList.length}');
                        if (!controller.isLastPage.value) {
                          controller.nextPage(true);
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
      ),
    );
  }

  Widget buildFollowUpForm({
    required TextEditingController dateController,
    required TextEditingController reviewController,
    required VoidCallback onSave,
    required VoidCallback onClose,
    required Widget tagWidget,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Center(
              child: Text(
                "Add Next Followup",
                style:
                    Styles.getstyle(fontweight: FontWeight.bold, fontsize: 22),
              ),
            ),
            const SizedBox(height: 16),
            // Follow-up Date Field
            Text(
              "Follow up Date",
              style: Styles.getstyle(
                fontweight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: dateController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "mm/dd/yyyy",
                hintStyle: Styles.getstyle(
                    fontweight: FontWeight.w500,
                    fontcolor: ColorPallets.fadegrey),
                suffixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onTap: () => controller.selectDate(context),
            ),
            const SizedBox(height: 16),

            // Review Field
            Text(
              "Review",
              style: Styles.getstyle(
                fontweight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: reviewController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Say it",
                hintStyle: Styles.getstyle(
                    fontweight: FontWeight.w500,
                    fontcolor: ColorPallets.fadegrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Tag Widget
            tagWidget,
            const SizedBox(height: 16),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onClose,
                  child: Text(
                    "Close",
                    style: Styles.getstyle(
                        fontweight: FontWeight.w600,
                        fontcolor: Colors.redAccent),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: onSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPallets.themeColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  child: Text(
                    "Save",
                    style: Styles.getstyle(
                        fontweight: FontWeight.w600,
                        fontcolor: ColorPallets.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _noData extends StatelessWidget {
  const _noData({
    required ResponsiveUI ui,
  }) : _ui = ui;

  final ResponsiveUI _ui;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _ui.screenHeight / 1.9,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off,
            size: _ui.heightPercent(14),
            color: ColorPallets.themeColor,
          ),
          Text(
            'No Data..',
            style: Styles.getstyle(
              fontweight: FontWeight.w600,
              fontsize: _ui.widthPercent(5),
            ),
          )
        ],
      ),
    );
  }
}
