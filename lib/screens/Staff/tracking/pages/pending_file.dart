import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/pending_files.dart';
import 'package:shiva_poly_pack/data/model/pending_files.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/pages/material/pending_files_card.dart';

import '../../../../data/model/follow_up.dart';
import '../../../../material/color_pallets.dart';

class PendingFile extends GetView<PendingFilesController> {
  PendingFile({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    controller.getApiData();
    return Scaffold(
      backgroundColor: ColorPallets.white,
      appBar: AppBar(
        backgroundColor: ColorPallets.white,
        bottom: PreferredSize(
          preferredSize: Size(
            _ui.widthPercent(100),
            _ui.heightPercent(2),
          ),
          child: Divider(
            indent: _ui.widthPercent(6),
            endIndent: _ui.widthPercent(6),
            color: Colors.grey.shade400,
            thickness: 1.2,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Pending Files',
          style: Styles.getstyle(
            fontweight: FontWeight.bold,
            fontsize: _ui.widthPercent(6),
          ),
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
            Get.back();
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
                                      controller.selectedOption.value,
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
            Obx(
              () {
                if (controller.isloading.value) {
                  return ProgressIndicatorWidget(
                    color: ColorPallets.themeColor,
                  );
                } else if (controller.pendingFilesList.length == 0) {
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
                } else {
                  return Expanded(
                    child: Obx(
                      () => ListView.builder(
                        itemCount: controller.pendingFilesList.length,
                        itemBuilder: (context, index) {
                          final item = controller.pendingFilesList[index];
                          controller.formatDate(item.createdDate.toString());
                          return Padding(
                            padding:
                                EdgeInsets.only(bottom: _ui.heightPercent(0.4)),
                            child: PendingFilesCard(item: item),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            )
            // FutureBuilder<PendingFilesResponse>(
            //   future: controller.getApiData(),
            //   builder: (context, snapshot) {

            //   },
            // ),
            // if (controller.pendingFilesList.length != 0)
            //   // Pagination controls
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       IconButton(
            //         icon: Icon(Icons.chevron_left),
            //         onPressed: () {
            //           // Implement previous page logic
            //         },
            //       ),
            //       Text('1 2 ... 99'),
            //       IconButton(
            //         icon: Icon(Icons.chevron_right),
            //         onPressed: () {
            //           // Implement next page logic
            //         },
            //       ),
            //     ],
            //   ),
          ],
        ),
      ),
    );
  }
}
