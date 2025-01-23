import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/dasboard.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/sign_out_dailoge.dart';
import 'package:shiva_poly_pack/material/styles.dart';
import 'package:shiva_poly_pack/routes/app_routes.dart';
import 'package:shiva_poly_pack/screens/Customer/home/notification.dart';

import '../../../material/home_card.dart';

class DashboardScreen extends GetView<DasboardController> {
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
            onPressed: () => controller.showNotificationMenu(),
          ),
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: ColorPallets.white,
            ),
            onPressed: () => Get.toNamed(Routes.cus_profile),
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: ColorPallets.white,
            ),
            onPressed: () {
              SignOutDialog.showSignOutDialog(context);
            },
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
          itemCount: controller.cardData.length,
          itemBuilder: (context, index) {
            final data = controller.cardData[index];
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
