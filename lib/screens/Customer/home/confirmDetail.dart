import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/model/cus_pending_order.dart';
import 'package:shiva_poly_pack/data/services/validation.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/image_preview.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';
import 'package:shiva_poly_pack/screens/Customer/home/notification.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/preview.dart';

import '../../../routes/app_routes.dart';

class OrderDetailScreen extends StatefulWidget {
  final PendingOrderData orderData;
  final OrderHistory? orderHistory;
  final bool allOrders;

  const OrderDetailScreen(
      {super.key,
      required this.orderData,
      required this.orderHistory,
      required this.allOrders});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    String baseUrl = 'https://spolypack.com/';
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
          // IconButton(
          //   icon: Icon(
          //     Icons.notifications_active,
          //     color: ColorPallets.white,
          //   ),
          //   onPressed: () => _showNotificationMenu(),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(widget.orderData.uniqueNumber.toString(),
                    style: Styles.getstyle(fontweight: FontWeight.bold)),
              ),
              Divider(),
              SizedBox(height: _ui.heightPercent(1)),
              GestureDetector(
                onTap: () => ImagePreview().showImagePreview(
                    baseUrl +
                        'OrderImages' +
                        '/' +
                        widget.orderData.orderPic.toString(),
                    context),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: baseUrl +
                          'OrderImages' +
                          '/' +
                          widget.orderData.orderPic.toString(),
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProgressIndicatorWidget(),
                      ),
                      width: _ui.widthPercent(33),
                      height: _ui.heightPercent(18),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  widget.orderData.jobName.toString(),
                  style: Styles.getstyle(),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildDetailColumn(
                      'POUCH TYPE',
                      widget.orderData.pouchType.toString(),
                      context,
                      ColorPallets.fadegrey,
                      ColorPallets.white),
                  buildDetailColumn('STAGE', widget.orderData.stage.toString(),
                      context, null, ColorPallets.white,
                      isHighlighted: true),
                ],
              ),
              SizedBox(height: 16),
              if (!widget.allOrders)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildDetailColumn(
                        'ESTIMATED DISPATCH DATE',
                        formatWithMonDate(
                            widget.orderData.dispatchDate.toString()),
                        context,
                        ColorPallets.white,
                        ColorPallets.fadegrey),
                    // buildDetailColumn(
                    //     'ESTIMATED DELIVERY',
                    //     formatDate(orderData.dispatchDate!
                    //         .add(
                    //           Duration(days: 7),
                    //         )
                    //         .toString()),
                    //     context,
                    //     ColorPallets.white,
                    //     ColorPallets.themeColor),
                  ],
                ),
              SizedBox(height: widget.allOrders ? 18 : 24),
              buildTimeline(_ui, baseUrl),
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
          Text(
            label,
            style: Styles.getstyle(
              fontcolor: ColorPallets.fadegrey,
              fontsize: ui.widthPercent(3),
            ),
          ),
          SizedBox(height: 4),
          Card(
            child: Container(
              alignment: Alignment.center,
              width: ui.widthPercent(40),
              padding: EdgeInsets.symmetric(
                horizontal: ui.widthPercent(1),
                vertical: ui.heightPercent(1),
              ),
              decoration: BoxDecoration(
                color: isHighlighted ? ColorPallets.themeColor : bg_color,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: Styles.getstyle(
                  fontcolor: txt_color,
                  fontsize: ui.widthPercent(3.6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimeline(ResponsiveUI ui, String headUrl) {
    var steps = [];
    if (widget.orderData.metal != 0 &&
        widget.orderData.pouchType != 'Roll Form') {
      steps = [
        {'title': 'Cylinder'},
        {'title': 'Printing'},
        {'title': 'Lamination & Metal'},
        {'title': 'Lamination & Poly'},
        {'title': 'Slatting'},
        {'title': 'Pouch Making'},
        {'title': 'Dispatch'},
      ];
    } else if (widget.orderData.pouchType == 'Roll Form') {
      steps = [
        {'title': 'Cylinder'},
        {'title': 'Printing'},
        {'title': 'Lamination & Metal'},
        {'title': 'Lamination & Poly'},
        {'title': 'Slatting'},
        // {'title': 'Pouch Making'},
        {'title': 'Dispatch'},
      ];
    } else {
      steps = [
        {'title': 'Cylinder'},
        {'title': 'Printing'},
        // {'title': 'Lamination & Metal'},
        {'title': 'Lamination & Poly'},
        {'title': 'Slatting'},
        {'title': 'Pouch Making'},
        {'title': 'Dispatch'},
      ];
    }

    return ListView.builder(
      itemCount: steps.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final step = steps[index];

        if (index < widget.orderData.orderHistories.length) {
          final moveinDate = widget.orderData.orderHistories[index].movein;
          step['date'] = moveinDate;
        } else {
          step['date'] = '';
        }
        if (index < widget.orderData.orderHistories.length) {
          final image = widget.orderData.orderHistories[index].image;
          step['image'] = image;
        } else {
          step['image'] = '';
        }
        return Column(
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  child: Center(
                    child: Icon(
                      index <= widget.orderData.stageNumber!.toInt()
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
                SizedBox(
                  width: ui.widthPercent(3),
                ),
                if (step['image'] != '')
                  GestureDetector(
                    onTap: () => ImagePreview().showImagePreview(
                        headUrl + step['image'].toString(), context),
                    child: SizedBox(
                      height: ui.heightPercent(4),
                      width: ui.widthPercent(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(ui.widthPercent(2)),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: headUrl + step['image'].toString(),
                          placeholder: (context, url) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ProgressIndicatorWidget(),
                          ),
                        ),
                      ),
                    ),
                  ),
                Spacer(),
                if (step['date'] != '' &&
                    widget.orderHistory?.movein != null &&
                    index <= widget.orderData.stageNumber!.toInt())
                  Text(
                    formatWithMonDate(step['date'].toString()),
                    style: Styles.getstyle(
                      fontweight: FontWeight.bold,
                      fontsize: ui.widthPercent(3.5),
                    ),
                  ),
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
