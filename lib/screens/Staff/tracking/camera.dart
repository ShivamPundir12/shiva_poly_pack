import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/camera.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/material/bottom_appbar.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/sign_out_dailoge.dart';
import 'package:shiva_poly_pack/material/styles.dart';

import '../../../material/custom_card.dart';

class UploadPictureScreen extends GetView<UploadPictureController> {
  final List<Map<String, dynamic>> menuItems = [
    {"icon": Icons.check_circle, "title": "New Leads", "color": Colors.green},
    {"icon": Icons.book, "title": "Pending Files", "color": Colors.orange},
    {
      "icon": Icons.attach_money,
      "title": "Follow Ups",
      "color": Colors.blue,
    },
    {
      "icon": Icons.person_add,
      "title": "Add New Customer",
      "color": Colors.red
    },
    {"icon": Icons.list_alt_outlined, "title": "List", "color": Colors.orange},
    {
      "icon": Icons.person_2,
      "title": "Final Customer",
      "color": Colors.amberAccent
    },
  ];
  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'CRM',
          style: Styles.getstyle(fontweight: FontWeight.bold, fontsize: 26),
        ),
        actions: [
          IconButton(
            onPressed: () {
              SignOutDialog.showSignOutDialog(context);
            },
            icon: Icon(
              Icons.logout,
              color: ColorPallets.themeColor,
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Container(
        height: _ui.heightPercent(12),
        width: _ui.widthPercent(15),
        margin: EdgeInsets.only(top: _ui.heightPercent(3.9)),
        child: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: ColorPallets.themeColor2,
          tooltip: 'Camera',
          onPressed: () => controller.navigationSet(),
          child: Obx(
            () => Icon(
              controller.toggledPhoto.value
                  ? CupertinoIcons.camera
                  : CupertinoIcons.qrcode,
              color: ColorPallets.white,
              size: controller.toggledPhoto.value
                  ? _ui.heightPercent(4)
                  : _ui.heightPercent(4.5),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: ColorPallets.themeColor2,
        shape: CurvedNotchedRectangle(),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: _ui.widthPercent(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => controller.toggleState('photo'),
                child: Obx(
                  () => Text(
                    'Take Photo',
                    style: Styles.getstyle(
                      fontcolor: controller.toggledPhoto.value
                          ? ColorPallets.white
                          : Colors.black.withOpacity(0.4),
                      fontweight: controller.toggledPhoto.value
                          ? FontWeight.bold
                          : FontWeight.w300,
                      fontsize: controller.toggledPhoto.value
                          ? _ui.widthPercent(5)
                          : _ui.widthPercent(4.5),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => controller.toggleState('scanner'),
                child: Obx(
                  () => Text(
                    'Scan QR',
                    style: Styles.getstyle(
                      fontcolor: controller.toggledPhoto.value
                          ? Colors.black.withOpacity(0.4)
                          : ColorPallets.white,
                      fontweight: controller.toggledPhoto.value
                          ? FontWeight.w300
                          : FontWeight.bold,
                      fontsize: controller.toggledPhoto.value
                          ? _ui.widthPercent(4.5)
                          : _ui.widthPercent(5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        notchMargin: 18.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: _ui.heightPercent(1),
          horizontal: _ui.widthPercent(5),
        ),
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 22.0,
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return CustomCard(
              title: item['title'],
              backgroundColor: item['color'],
              icon: item['icon'],
              onTap: () => controller.navigate(card_name: item['title']),
            );
          },
        ),
      ),
    );
  }
}
