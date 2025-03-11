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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorPallets.themeColor,
        title: Text(
          'Shiva Poly Packs',
          style: Styles.getstyle(
            fontcolor: ColorPallets.white,
            fontweight: FontWeight.w600,
            fontsize: _ui.widthPercent(5.5),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: ColorPallets.white),
            onPressed: () {
              controller.goToProfile();
              Get.toNamed(Routes.cus_profile);
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: ColorPallets.white),
            onPressed: () => SignOutDialog.showSignOutDialog(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorPallets.themeColor.withOpacity(0.1),
              Colors.grey[100]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _ui.widthPercent(4),
              vertical: _ui.heightPercent(2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Dashboard',
                  style: Styles.getstyle(
                    fontweight: FontWeight.bold,
                    fontsize: _ui.widthPercent(7),
                    fontcolor: Colors.black87,
                  ),
                ),
                SizedBox(height: _ui.heightPercent(2)),
                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: _ui.widthPercent(4),
                      mainAxisSpacing: _ui.heightPercent(2),
                      childAspectRatio: 1,
                    ),
                    itemCount: controller.cardData.length,
                    itemBuilder: (context, index) {
                      final data = controller.cardData[index];
                      return EnhancedHomeCard(
                        icon: data['icon'],
                        title: data['title'],
                        backgroundColor: data['backgroundColor'],
                        onTap: data['onTap'],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
