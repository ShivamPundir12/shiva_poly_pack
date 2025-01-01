import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/material/styles.dart';
import 'package:shiva_poly_pack/routes/app_routes.dart';

class SignOutDialog {
  static Future<bool?> showSignOutDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Sign Out',
            style: Styles.getstyle(fontsize: 18, fontweight: FontWeight.bold),
          ),
          content: Text(
            'Are you sure you want to sign out?',
            style: Styles.getstyle(fontsize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                'Cancel',
                style: Styles.getstyle(
                  fontsize: 14,
                  fontcolor: Colors.red,
                  fontweight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorPallets.themeColor,
              ),
              onPressed: () async {
                LoadingView.show();
                await LocalStorageManager.signOut();
                Get.offNamedUntil(Routes.welcome_screen, (r) => false);
                LoadingView.hide();
              },
              child: Text(
                'Sign Out',
                style: Styles.getstyle(
                  fontsize: 14,
                  fontcolor: ColorPallets.white,
                  fontweight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
