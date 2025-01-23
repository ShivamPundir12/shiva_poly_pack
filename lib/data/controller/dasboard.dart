import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/screens/Customer/home/all_order.dart';
import 'package:shiva_poly_pack/screens/Customer/home/complaint.dart';
import 'package:shiva_poly_pack/screens/Customer/home/requestFollowUp.dart';

import '../../routes/app_routes.dart';
import '../../screens/Customer/home/notification.dart';

class DasboardController extends GetxController {
  final RxList<Map<String, dynamic>> cardData = [
    {
      'icon': 'assets/icons/order.svg',
      'title': 'Pending Orders',
      'backgroundColor': Colors.green,
      'onTap': () => Get.toNamed(Routes.confirm_order),
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
      'onTap': () => Get.to(() => ContactScreen()),
    },
    {
      'icon': 'assets/icons/all_order.svg',
      'title': 'All Orders',
      'backgroundColor': Colors.red,
      'onTap': () => Get.to(() => AllOrders()),
    },
    {
      'icon': 'assets/icons/complaint.svg',
      'title': 'Complaint',
      'backgroundColor': Colors.teal,
      'onTap': () => Get.to(() => ComplaintScreen()),
    },
    // {
    //   'icon': 'assets/icons/common_package.svg',
    //   'title': 'Order for Common Package',
    //   'backgroundColor': Colors.teal,
    //   'onTap': () => print('Order for Common Package'),
    // },
  ].obs;

  void showNotificationMenu() {
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
}
