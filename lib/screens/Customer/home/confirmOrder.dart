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

import '../../../data/model/cus_confirmOrder.dart';

class ConfirmedOrdersScreen extends GetView<ConfirmorderController> {
  final List<Order> orders = [
    Order(
        id: '10001',
        name: 'Sai Diskha Haldi Powder Roll Form',
        date: '11-27-2024'),
    Order(
        id: '10002',
        name: 'Sai Diskha Tikha Mirch 3 Side Seal',
        date: '11-28-2024'),
    // Add more orders here
  ];

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
                        return InkWell(
                          onTap: () {
                            Get.to(() => OrderDetailScreen(orderData: order));
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
        ],
      ),
    );
  }
}
