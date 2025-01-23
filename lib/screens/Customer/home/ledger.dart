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
import 'package:shiva_poly_pack/material/no_data.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';

import '../../../routes/app_routes.dart';

class LedgerReportScreen extends GetView<LedgerReportController> {
  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Scaffold(
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
          IconButton(
            icon: Icon(
              Icons.notifications_active,
              color: ColorPallets.white,
            ),
            onPressed: () => controller.showNotificationMenu(),
          ),
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
          FutureBuilder<LedgerModel>(
              future: controller.getApiData(1),
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: ProgressIndicatorWidget(),
                  );
                } else if (!snapshot.hasData) {
                  return NoDataUI();
                } else {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: controller.ledgerDatalist.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final item = data?.data[index];
                        return Obx(() {
                          final isExpanded =
                              controller.expandedIndex.value == index;
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: _ui.widthPercent(2)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: Card(
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          controller.toggleExpand(index),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 8),
                                        color: index.isEven
                                            ? Colors.grey[300]
                                            : ColorPallets.white,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                item?.orderId.toString() ?? '0',
                                                style: Styles.getstyle(
                                                    fontsize:
                                                        _ui.widthPercent(3),
                                                    fontweight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Container(
                                              width: _ui.widthPercent(60),
                                              child: Text(
                                                item?.ledger.toString() ?? '',
                                                style: Styles.getstyle(
                                                    fontsize:
                                                        _ui.widthPercent(3),
                                                    fontweight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                formatDate(item?.createdDate
                                                        .toString() ??
                                                    ''),
                                                textAlign: TextAlign.right,
                                                style: Styles.getstyle(
                                                    fontsize:
                                                        _ui.widthPercent(3),
                                                    fontweight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            SizedBox(
                                              width: _ui.widthPercent(4),
                                            ),
                                            isExpanded
                                                ? Transform.rotate(
                                                    angle: pi / 2,
                                                    child: SvgPicture.asset(
                                                      'assets/icons/list.svg',
                                                      height: _ui
                                                          .heightPercent(1.6),
                                                      width:
                                                          _ui.widthPercent(1.6),
                                                    ),
                                                  )
                                                : SvgPicture.asset(
                                                    'assets/icons/list.svg',
                                                    height:
                                                        _ui.heightPercent(1.6),
                                                    width:
                                                        _ui.widthPercent(1.6),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Expanded content
                                    if (isExpanded)
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        color: Colors.grey[100],
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  // Request Invoice Logic
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      ColorPallets.themeColor2,
                                                ),
                                                child: Text(
                                                  "Request for the Invoice",
                                                  style: Styles.getstyle(
                                                      fontweight:
                                                          FontWeight.bold,
                                                      fontcolor:
                                                          ColorPallets.white,
                                                      fontsize: 14),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  );
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
