import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/all_order.dart';
import 'package:shiva_poly_pack/data/model/cus_pending_order.dart';
import 'package:shiva_poly_pack/data/services/validation.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/material/no_data.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/screens/Customer/home/confirmDetail.dart';

import '../../../material/all_order_card.dart';
import '../../../material/color_pallets.dart';
import '../../../material/styles.dart';
import '../../../routes/app_routes.dart';

class AllOrders extends GetView<AllOrderController> {
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
                  'All Orders',
                  style: Styles.getstyle(
                      fontsize: _ui.widthPercent(5),
                      fontweight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Divider(),
          _buildSearchAndSortUI(_ui),
          SizedBox(
            height: _ui.heightPercent(2),
          ),
          FutureBuilder<PendingOrderResponse>(
              future: controller.getApiData(1),
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: ProgressIndicatorWidget());
                } else if (!snapshot.hasData) {
                  return Center(
                    child: NoDataUI(),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data?.data.length, // Example count
                      itemBuilder: (context, index) {
                        final allOrder = data?.data[index];
                        return OrderCard(
                          onPressed: () => Get.to(
                            () => OrderDetailScreen(orderData: allOrder!),
                          ),
                          orderId: allOrder?.uniqueNumber.toString() ?? '',
                          productName: allOrder?.jobName.toString() ?? '',
                          quantity: 'x ${allOrder?.pcsEstimate}',
                          date: formatDate(allOrder?.dispatchDate.toString() ??
                              DateTime.now().toString()),
                          status: allOrder?.stage.toString() ?? '',
                        );
                      },
                    ),
                  );
                }
              }),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       IconButton(
          //         icon: Icon(Icons.arrow_back),
          //         onPressed: () {
          //           // Handle previous page
          //         },
          //       ),
          //       Text('1 2 ..... 99'), // Example pagination
          //       IconButton(
          //         icon: Icon(Icons.arrow_forward),
          //         onPressed: () {
          //           // Handle next page
          //         },
          //       ),
          //     ],
          //   ),
          // ),
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
