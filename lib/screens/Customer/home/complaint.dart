import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/complaint.dart';
import 'package:shiva_poly_pack/data/services/validation.dart';
import 'package:shiva_poly_pack/material/buttons.dart';
import 'package:shiva_poly_pack/material/responsive.dart';

import '../../../material/color_pallets.dart';
import '../../../material/styles.dart';
import '../../../routes/app_routes.dart';

class ComplaintScreen extends GetView<ComplaintController> {
  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: SingleChildScrollView(
        child: Container(
          height: isKeyboardVisible
              ? _ui.heightPercent(100)
              : _ui.heightPercent(95),
          child: Column(
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
                    margin:
                        EdgeInsets.symmetric(vertical: _ui.heightPercent(1)),
                    child: Text(
                      'Complaint',
                      style: Styles.getstyle(
                          fontsize: _ui.widthPercent(5),
                          fontweight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  textAlign: TextAlign.start,
                                  'Order no.',
                                  style: Styles.getstyle(
                                    fontweight: FontWeight.w600,
                                    fontsize: _ui.widthPercent(4),
                                  ),
                                ),
                              ),
                              Card(
                                color: ColorPallets.white,
                                child: TextFormField(
                                  validator: (value) =>
                                      ValidationService.normalvalidation(
                                          value, 'Order no'),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: controller.setOrderNumber,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  textAlign: TextAlign.start,
                                  'Order Date',
                                  style: Styles.getstyle(
                                    fontweight: FontWeight.w600,
                                    fontsize: _ui.widthPercent(4),
                                  ),
                                ),
                              ),
                              Card(
                                color: ColorPallets.white,
                                child: TextFormField(
                                  validator: (value) =>
                                      ValidationService.normalvalidation(
                                          value, 'Order no'),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: controller.setOrderDate,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            textAlign: TextAlign.start,
                            'Complaint reason',
                            style: Styles.getstyle(
                              fontweight: FontWeight.w600,
                              fontsize: _ui.widthPercent(4),
                            ),
                          ),
                        ),
                        Obx(() => Card(
                              color: ColorPallets.white,
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) =>
                                    ValidationService.normalvalidation(
                                        value, 'Complaint Reason'),
                                value: controller.complaintReason.value.isEmpty
                                    ? null
                                    : controller.complaintReason.value,
                                items: controller.reasons
                                    .map((reason) => DropdownMenuItem(
                                        value: reason, child: Text(reason)))
                                    .toList(),
                                onChanged: (v) =>
                                    controller.setComplaintReason(v ?? ''),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            textAlign: TextAlign.start,
                            'Message',
                            style: Styles.getstyle(
                              fontweight: FontWeight.w600,
                              fontsize: _ui.widthPercent(4),
                            ),
                          ),
                        ),
                        Card(
                          color: ColorPallets.white,
                          child: TextFormField(
                            validator: (value) =>
                                ValidationService.normalvalidation(
                                    value, 'Message'),
                            maxLines: 4,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            onChanged: controller.setMessage,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text('Upload File/Video/Image'),
                        SizedBox(
                          width: _ui.widthPercent(3),
                        ),
                        Card(
                          color: ColorPallets.white,
                          child: InkWell(
                            onTap: () => controller.pickImage(),
                            child: Container(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: ColorPallets.fadegrey
                                          .withOpacity(0.4),
                                    ),
                                  ),
                                ),
                                width: _ui.widthPercent(12),
                                height: _ui.heightPercent(4),
                                child: Icon(Icons.add)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: _ui.heightPercent(2)),
                    Obx(
                      () {
                        if (controller.local_image.isNotEmpty) {
                          return Stack(
                            fit: StackFit.loose,
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: _ui.heightPercent(10),
                                width: _ui.heightPercent(25),
                                child: Image.file(
                                  File(controller.local_image.value),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              IconButton(
                                style: IconButton.styleFrom(
                                    shape: CircleBorder(),
                                    backgroundColor: ColorPallets.white),
                                onPressed: () => controller.removeData(context),
                                icon: Icon(Icons.remove_circle_outline),
                                color: Colors.red,
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    SizedBox(height: _ui.heightPercent(3)),
                    Center(
                      child: InkWell(
                          onTap: () => controller.submitComplaint(),
                          child:
                              reuseable_button(ui: _ui, button_text: 'Submit')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
