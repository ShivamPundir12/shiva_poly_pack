import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/confirmOrder.dart';
import 'package:shiva_poly_pack/data/model/cus_pending_order.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/confirm_orderCard.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/material/no_data.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';
import 'package:shiva_poly_pack/routes/app_routes.dart';
import 'package:shiva_poly_pack/screens/Customer/home/confirmDetail.dart';

class ConfirmedOrdersScreen extends GetView<ConfirmorderController> {
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
        iconTheme: IconThemeData(color: ColorPallets.white),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_active,
              color: ColorPallets.white,
            ),
            onPressed: () {},
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
                  'Pending Orders',
                  style: Styles.getstyle(
                      fontsize: _ui.widthPercent(5),
                      fontweight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Divider(),
          FutureBuilder<PendingOrderResponse>(
              future: controller.getApiData(1),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: ProgressIndicatorWidget(),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: NoDataUI(),
                  );
                } else {
                  final data = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data?.data.length,
                      itemBuilder: (context, index) {
                        final order = data?.data[index];
                        final history = order?.orderHistories.firstWhere(
                          (element) => element.orderId == order.id,
                          orElse: () => OrderHistory(
                            id: 0,
                            movein: '',
                            duration: '',
                            image: '',
                            progressStage: 0,
                            orderId: 0,
                            stage: '',
                          ), // Provide a default OrderHistory object
                        );
                        return InkWell(
                          onTap: () {
                            if (history?.id == 0) {
                              Get.snackbar(
                                'Error',
                                'No order history found',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: ColorPallets.white,
                              );
                            } else {
                              Get.to(() => OrderDetailScreen(
                                    orderData: order,
                                    orderHistory: history,
                                    allOrders: false,
                                  ));
                            }
                          },
                          child: ProductCard(
                            pendingOrderData: order!,
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
          Obx(() {
            if (controller.pendingOrderList.isNotEmpty &&
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
                      print('Length : ${controller.pendingOrderList.length}');
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
}
