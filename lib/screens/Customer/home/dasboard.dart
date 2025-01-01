import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';
import 'package:shiva_poly_pack/routes/app_routes.dart';
import 'package:shiva_poly_pack/screens/Customer/home/notification.dart';

import '../../../material/home_card.dart';

class DashboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cardData = [
    {
      'icon': 'assets/icons/order.svg',
      'title': 'Confirmed Orders',
      'backgroundColor': Colors.green,
      'onTap': () => print('Confirmed Orders'),
    },
    {
      'icon': 'assets/icons/ledger.svg',
      'title': 'Ledger Report',
      'backgroundColor': Colors.orange,
      'onTap': () => Get.toNamed(Routes.ledger_report),
    },
    {
      'icon': 'assets/icons/follow_up.svg',
      'title': 'Request for Follow Up',
      'backgroundColor': Colors.blue,
      'onTap': () => print('Request for Follow Up'),
    },
    {
      'icon': 'assets/icons/all_order.svg',
      'title': 'All Orders',
      'backgroundColor': Colors.red,
      'onTap': () => print('All Orders'),
    },
    {
      'icon': 'assets/icons/complaint.svg',
      'title': 'Complaint',
      'backgroundColor': Colors.redAccent,
      'onTap': () => print('Complaint'),
    },
    {
      'icon': 'assets/icons/common_package.svg',
      'title': 'Order for Common Package',
      'backgroundColor': Colors.teal,
      'onTap': () => print('Order for Common Package'),
    },
  ];

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

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
          ),
          itemCount: cardData.length,
          itemBuilder: (context, index) {
            final data = cardData[index];
            return HomeCard(
              icon: data['icon'],
              title: data['title'],
              backgroundColor: data['backgroundColor'],
              onTap: data['onTap'],
            );
          },
        ),
      ),
    );
  }
}
