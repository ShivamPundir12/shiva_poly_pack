import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/model/cus_pending_order.dart';
import 'package:shiva_poly_pack/data/services/validation.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';
import 'package:shiva_poly_pack/screens/Customer/home/notification.dart';

import '../../../routes/app_routes.dart';

class OrderDetailScreen extends StatelessWidget {
  final PendingOrderData orderData;

  const OrderDetailScreen({super.key, required this.orderData});
  @override
  Widget build(BuildContext context) {
    String baseUrl = 'https://spolypack.com/OrderImages';
    void _showNotificationMenu() {
      Get.dialog(
        NotificationMenu(
          onDisable: () {
            print('Disable Notifications');
            Get.back(); // Close menu
          },
          onAllowAll: () {
            print('Allow All Notifications');
            Get.back(); // Close menu
          },
          onFestive: () {
            print('Only Festive Notifications');
            Get.back(); // Close menu
          },
        ),
        barrierColor: Colors.transparent, // Ensures a transparent background
        useSafeArea: true,
      );
    }

    ResponsiveUI _ui = ResponsiveUI(context);
    return Scaffold(
      appBar: AppBar(
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
            onPressed: () => _showNotificationMenu(),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(orderData.uniqueNumber.toString(),
                    style: Styles.getstyle(fontweight: FontWeight.bold)),
              ),
              Divider(),
              SizedBox(height: _ui.heightPercent(1)),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    baseUrl + '/' + orderData.orderPic.toString(),
                    width: _ui.widthPercent(30),
                    height: _ui.heightPercent(15),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  orderData.jobName.toString(),
                  style: Styles.getstyle(),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildDetailColumn(
                      'POUCH TYPE',
                      orderData.pouchType.toString(),
                      context,
                      ColorPallets.fadegrey,
                      ColorPallets.white),
                  buildDetailColumn('STAGE', orderData.stage.toString(),
                      context, null, ColorPallets.white,
                      isHighlighted: true),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildDetailColumn(
                      'DISPATCH DATE',
                      formatDate(orderData.dispatchDate.toString()),
                      context,
                      ColorPallets.white,
                      ColorPallets.fadegrey),
                  buildDetailColumn(
                      'ESTIMATED DELIVERY',
                      formatDate(orderData.dispatchDate!
                          .add(
                            Duration(days: 7),
                          )
                          .toString()),
                      context,
                      ColorPallets.white,
                      ColorPallets.themeColor),
                ],
              ),
              SizedBox(height: 24),
              buildTimeline(_ui),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailColumn(String label, String value, BuildContext context,
      Color? bg_color, Color? txt_color,
      {bool isHighlighted = false}) {
    ResponsiveUI ui = ResponsiveUI(context);
    return Container(
      width: ui.widthPercent(42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: Styles.getstyle(
                  fontcolor: ColorPallets.fadegrey,
                  fontsize: ui.widthPercent(3))),
          SizedBox(height: 4),
          Card(
            child: Container(
              alignment: Alignment.center,
              width: ui.widthPercent(40),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isHighlighted ? ColorPallets.themeColor : bg_color,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: Text(value, style: Styles.getstyle(fontcolor: txt_color)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimeline(ResponsiveUI ui) {
    final steps = [
      {'title': 'Cylinder', 'date': '28-Nov-2024'},
      {'title': 'Printing', 'date': '01-Dec-2024'},
      {'title': 'Lamination & Metal'},
      {'title': 'Lamination & Poly'},
      {'title': 'Slatting'},
      {'title': 'Pouch Making'},
      {'title': 'Dispatch'},
    ];

    return ListView.builder(
      itemCount: steps.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final step = steps[index];

        return Column(
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  child: Center(
                    child: Icon(
                      index <= orderData.stageNumber!.toInt()
                          ? Icons.check_circle_outline
                          : Icons.circle_sharp,
                      size: ui.widthPercent(6),
                      color: ColorPallets.themeColor,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  step['title']!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                // Spacer(),
                // if (step.containsKey('date'))
                //   Text(
                //     step['date']!,
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 12,
                //     ),
                //   ),
              ],
            ),
            if (index < steps.length - 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: ui.widthPercent(2.9)),
                    alignment: Alignment.centerLeft,
                    height: 24,
                    width: ui.widthPercent(0.3),
                    color: ColorPallets.fadegrey2,
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
