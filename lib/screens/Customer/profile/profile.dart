import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/profile.dart';
import 'package:shiva_poly_pack/data/model/login.dart';
import 'package:shiva_poly_pack/data/services/validation.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/material/responsive.dart';

import '../../../material/styles.dart';
import '../../../routes/app_routes.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Scaffold(
      backgroundColor: ColorPallets.white2,
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
        ],
      ),
      bottomSheet: Container(
        margin: EdgeInsets.symmetric(vertical: _ui.heightPercent(1.4)),
        child: // Save and Cancel Buttons
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                if (controller.local_image.isNotEmpty) {
                  controller.local_image.value = '';
                }
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: _ui.widthPercent(11)),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: ColorPallets.themeColor),
                  borderRadius: BorderRadius.circular(6),
                ),
                backgroundColor: ColorPallets.white,
              ),
              child: Text(
                'Cancel',
                style: Styles.getstyle(
                    fontweight: FontWeight.w500,
                    fontcolor: ColorPallets.themeColor),
              ),
            ),
            ElevatedButton(
              onPressed: () => controller.updateProfile(),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: _ui.widthPercent(11)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                backgroundColor: ColorPallets.themeColor,
              ),
              child: Text(
                'Save',
                style: Styles.getstyle(
                    fontweight: FontWeight.w500, fontcolor: ColorPallets.white),
              ),
            ),
          ],
        ),
      ),
      body: Form(
        key: controller.fromkey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Obx(() {
            controller.fetchProfile();
            return controller.isLoading.value
                ? Center(
                    child: ProgressIndicatorWidget(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: _ui.widthPercent(10),
                              child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                    if (controller.local_image.isNotEmpty) {
                                      controller.local_image.value = '';
                                    }
                                    controller.onedit.value = false;
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: ColorPallets.themeColor2,
                                  ))),
                          Container(
                            width: _ui.widthPercent(70),
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: _ui.heightPercent(1)),
                            child: Text(
                              'Profile',
                              style: Styles.getstyle(
                                  fontsize: _ui.widthPercent(5),
                                  fontweight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      // Profile Picture with Edit Icon
                      Container(
                        height: _ui.heightPercent(15),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          fit: StackFit.passthrough,
                          children: [
                            Obx(
                              () => CircleAvatar(
                                radius: 50,
                                backgroundImage: controller
                                            .image_url.value.isNotEmpty &&
                                        controller.local_image.isEmpty
                                    ? NetworkImage(
                                        controller.url +
                                            controller.image_url.value,
                                      )
                                    : controller.local_image.value.isNotEmpty
                                        ? FileImage(
                                            File(controller.local_image.value),
                                          )
                                        : null,
                                child: controller.image_url.isEmpty &&
                                        controller.local_image.isEmpty
                                    ? Icon(
                                        CupertinoIcons.person,
                                        size: _ui.widthPercent(11),
                                      )
                                    : null,
                                backgroundColor: Colors.grey[300],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: _ui.widthPercent(19)),
                              child: IconButton(
                                style: IconButton.styleFrom(
                                    shape: CircleBorder(),
                                    backgroundColor: ColorPallets.white),
                                icon: Icon(Icons.edit_outlined,
                                    color: ColorPallets.fadegrey),
                                onPressed: () => controller.pickImage(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Username Field
                      _buildEditableField2(
                        context: context,
                        txtcontroller: controller.username,
                        label: 'Username',
                        value: 'example1234',
                      ),
                      const SizedBox(height: 10),

                      // Mobile Number Field
                      _buildEditableField2(
                        context: context,
                        txtcontroller: controller.phoneNo,
                        label: 'Mobile no.',
                        value: '+91 - 111 222 3333',
                      ),
                      const SizedBox(height: 10),

                      // Name Field
                      _buildEditableField(
                        context: context,
                        validator: (v) =>
                            ValidationService.normalvalidation(v, 'Name'),
                        txtcontroller: controller.username,
                        label: 'Name',
                        showIcon: true,
                        value: 'John Doe',
                        onEdit: () => controller.onEdit(),
                      ),
                      const SizedBox(height: 10),
                      // Email Address Field
                      _buildEditableField(
                        context: context,
                        validator: (v) =>
                            ValidationService.validateMobileNumber(v),
                        txtcontroller: controller.alternatePhoneno,
                        showIcon: true,
                        label: 'Alternate Mobile no.',
                        value: '1234567890',
                        onEdit: () => controller.onEdit(),
                      ),
                      const SizedBox(height: 10),
                      // Shipping Address Field
                      _buildEditableField(
                        context: context,
                        validator: (v) =>
                            ValidationService.normalvalidation(v, 'Location'),
                        txtcontroller: controller.location,
                        showIcon: true,
                        label: 'Location',
                        value: '13/ California, New York',
                        onEdit: () => controller.onEdit(),
                      ),

                      SizedBox(height: _ui.heightPercent(8)),
                    ],
                  );
          }),
        ),
      ),
    );
  }

  Widget _buildEditableField(
      {required String label,
      required String value,
      required bool showIcon,
      required VoidCallback onEdit,
      String? Function(String?)? validator,
      required TextEditingController txtcontroller,
      required BuildContext context}) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: Styles.getstyle(
                      fontweight: FontWeight.w600,
                      fontcolor: ColorPallets.fadegrey,
                      fontsize: _ui.widthPercent(4),
                    ),
                  ),
                  label == 'Name'
                      ? IconButton(
                          iconSize: _ui.widthPercent(6),
                          icon: Icon(Icons.edit_outlined,
                              color: ColorPallets.themeColor),
                          onPressed: onEdit,
                        )
                      : Container()
                ],
              ),
              const SizedBox(height: 4),
              Obx(
                () => Card(
                  clipBehavior: Clip.none,
                  child: TextFormField(
                    controller: txtcontroller,
                    validator: validator,
                    readOnly: controller.onedit.value ? false : true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEditableField2(
      {required String label,
      required String value,
      required TextEditingController txtcontroller,
      required BuildContext context}) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Styles.getstyle(
                  fontweight: FontWeight.w600,
                  fontcolor: ColorPallets.fadegrey,
                  fontsize: _ui.widthPercent(4),
                ),
              ),
              const SizedBox(height: 4),
              TextFormField(
                controller: txtcontroller,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
