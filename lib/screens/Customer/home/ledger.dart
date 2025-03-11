import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shiva_poly_pack/data/controller/ledgercontroller.dart';
import 'package:shiva_poly_pack/data/model/ledger.dart';
import 'package:shiva_poly_pack/data/services/validation.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/material/ledger_card.dart';
import 'package:shiva_poly_pack/material/no_data.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';

import '../../../routes/app_routes.dart';

class LedgerReportScreen extends GetView<LedgerReportController> {
  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorPallets.themeColor,
        title: Text(
          'Shiva Poly Packs',
          style: Styles.getstyle(
              fontcolor: ColorPallets.white,
              fontweight: FontWeight.bold,
              fontsize: _ui.widthPercent(6)),
        ),
        actions: [
          // IconButton(
          //   icon: Icon(
          //     Icons.notifications_active,
          //     color: ColorPallets.white,
          //   ),
          //   onPressed: () => controller.showNotificationMenu(),
          // ),
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: ColorPallets.white,
            ),
            onPressed: () => Get.toNamed(Routes.cus_profile),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: _ui.widthPercent(10),
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                        if (controller.filterledgerDatalist.isNotEmpty) {
                          controller.filterledgerDatalist.clear();
                        }
                        controller.selectedOption.value = 'A-Z';
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: ColorPallets.themeColor2,
                      ))),
              Container(
                width: _ui.widthPercent(80),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: _ui.heightPercent(1)),
                child: Text(
                  'Ledger Report',
                  style: Styles.getstyle(
                      fontsize: _ui.widthPercent(5),
                      fontweight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Divider(),
          _buildSearchAndSortUI(_ui),
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _ui.widthPercent(4)),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'No.',
                      style: Styles.getstyle(
                        fontweight: FontWeight.w500,
                        fontsize: _ui.widthPercent(4),
                        fontcolor: ColorPallets.themeColor,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Order Name',
                      style: Styles.getstyle(
                        fontweight: FontWeight.w500,
                        fontsize: _ui.widthPercent(4),
                        fontcolor: ColorPallets.themeColor,
                      ),
                    ),
                  ),
                  Container(
                    width: _ui.widthPercent(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Date',
                      style: Styles.getstyle(
                        fontweight: FontWeight.w500,
                        fontsize: _ui.widthPercent(4),
                        fontcolor: ColorPallets.themeColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _ui.widthPercent(2)),
            child: Divider(
              color: Colors.black,
            ),
          ),
          // Ledger Report List
          Obx(() => controller.filterledgerDatalist.isEmpty
              ? FutureBuilder<LedgerModel>(
                  future: controller.getApiData(controller.currentPage.value),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: ProgressIndicatorWidget(),
                      );
                    } else if (!snapshot.hasData) {
                      return NoDataUI();
                    } else {
                      return Expanded(
                        child: Obx(
                          () => ListView.separated(
                            shrinkWrap: true,
                            itemCount: controller.ledgerDatalist.length,
                            separatorBuilder: (_, __) =>
                                Divider(height: _ui.heightPercent(2.5)),
                            itemBuilder: (context, index) {
                              final item = controller.ledgerDatalist[index];
                              return Obx(() {
                                final isExpanded =
                                    controller.expandedIndex.value == index;
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: _ui.widthPercent(2)),
                                  child: LedgerCard(
                                      index: index,
                                      isExpanded: isExpanded,
                                      item: item),
                                );
                              });
                            },
                          ),
                        ),
                      );
                    }
                  })
              : Obx(() {
                  if (controller.isloading.value) {
                    return Center(
                      child: ProgressIndicatorWidget(),
                    );
                  } else if (controller.filterledgerDatalist.isEmpty) {
                    return NoDataUI();
                  } else {
                    return Expanded(
                      child: Obx(
                        () => ListView.separated(
                          itemCount: controller.filterledgerDatalist.length,
                          separatorBuilder: (_, __) => const Divider(height: 2),
                          itemBuilder: (context, index) {
                            final item = controller.filterledgerDatalist[index];
                            return Obx(() {
                              final isExpanded =
                                  controller.expandedIndex.value == index;
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: _ui.widthPercent(2)),
                                child: LedgerCard(
                                    index: index,
                                    isExpanded: isExpanded,
                                    item: item),
                              );
                            });
                          },
                        ),
                      ),
                    );
                  }
                })),
          Obx(() {
            if (controller.ledgerDatalist.isNotEmpty &&
                controller.total_pages.value > 1) {
              // Pagination controls
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: () {
                      if (controller.currentPage.value > 1) {
                        controller.prevPage();
                      }
                    },
                  ),
                  Obx(() => Text(controller.currentPage.value.toString() +
                      " of " +
                      controller.total_pages.value.toString())),
                  IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: () {
                      print('Length : ${controller.ledgerDatalist.length}');
                      if (!controller.isLastPage.value) {
                        controller.nextPage();
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

  Widget _buildSearchAndSortUI(ResponsiveUI _ui) {
    return Row(
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
              if (value.isNotEmpty) {
                // controller.searchData(value);
              } else {
                // controller.filterpendingFilesList.clear();
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
            _buildSortButton(_ui),
          ],
        ),
      ],
    );
  }

  Widget _buildSortButton(ResponsiveUI _ui) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => controller.selectOption(Get.context!),
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade400, width: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            color: ColorPallets.white,
            child: Container(
              width: _ui.widthPercent(30),
              height: _ui.heightPercent(5),
              decoration: ShapeDecoration(
                color: ColorPallets.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: ColorPallets.fadegrey, width: 0.4),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(
                    () => Text(
                      controller.selectedOption.value,
                      style: Styles.getstyle(
                          fontweight: FontWeight.bold,
                          fontsize: _ui.widthPercent(6)),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/sort.svg',
                    height: _ui.heightPercent(2.8),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: _ui.widthPercent(0.3),
          height: _ui.heightPercent(4),
          color: ColorPallets.fadegrey,
        ),
      ],
    );
  }
}
