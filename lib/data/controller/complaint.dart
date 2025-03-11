import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/data/model/complaint.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';
import 'package:shiva_poly_pack/data/services/validation.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/material/responsive.dart';

import '../../material/styles.dart';

class ComplaintController extends GetxController {
  var orderNumber = TextEditingController();
  var orderID = ''.obs;
  var orderDate = TextEditingController();
  var complaintReason = ''.obs;
  var message = TextEditingController();
  RxString local_image = ''.obs;
  ApiService _apiService = ApiService();
  final ImagePicker _picker = ImagePicker();
  RxList<OrderNoModel> orderNo = <OrderNoModel>[].obs;
  RxBool isSubmitting = false.obs;
  RxBool gettingOrderNo = false.obs;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  List<String> reasons = [
    'Product Quality',
    'Late Delivery',
    'Wrong Item',
    'Others'
  ];

  void setOrderNumber(String value) {
    orderNumber.text = value;
  }

  void setOrderDate(String value) {
    orderDate.text = value;
  }

  void setComplaintReason(String value) {
    complaintReason.value = value;
  }

  void setMessage(String value) {
    message.text = value;
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      local_image.value = pickedFile.path;
      update();
      Get.snackbar('Success', 'Image selected successfully');
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  Future<void> submitComplaint() async {
    if (formkey.currentState!.validate() && local_image.value.isNotEmpty) {
      isSubmitting.value = true;
      final data = await _apiService.submitComplaint(
          token: getToken(),
          orderNo: int.parse(orderID.value),
          complaintReason: complaintReason.value,
          message: message.text,
          crmId: int.parse(
            LocalStorageManager.getUserId(),
          ),
          attachedFile: File(local_image.value));
      if (data['message'] != '') {
        clearData();
        Get.snackbar(
            backgroundColor: Colors.green,
            colorText: ColorPallets.white,
            'Info',
            data['message']);
      }
    } else {
      if (local_image.value.isEmpty) {
        Get.snackbar(
            backgroundColor: ColorPallets.themeColor2,
            colorText: ColorPallets.white,
            'Info',
            'Please provide the images of the issue!');
      }
    }
    isSubmitting.value = false;
    LoadingView.hide();
  }

  Future<void> removeData(BuildContext context) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Info',
          style: Styles.getstyle(fontweight: FontWeight.bold),
        ),
        content: Text(
          'Do you want to remove this media?',
          style: Styles.getstyle(),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'No',
                style: Styles.getstyle(
                    fontcolor: Colors.red, fontweight: FontWeight.bold),
              )),
          TextButton(
              onPressed: () {
                local_image.value = '';
                Get.back(canPop: true);
              },
              child: Text(
                'Yes',
                style: Styles.getstyle(fontweight: FontWeight.bold),
              ))
        ],
      ),
    );
  }

  Future<void> getOrders() async {
    gettingOrderNo.value = true;
    final data = await _apiService.getOrderNo();
    final orderData = data.orderNoModel;
    bool hasData = orderNo.any(
      (e) => orderData.any((d) => e.id != d.uniqueNo),
    );
    orderDate.text = formatDate(DateTime.now().toString());
    if (!hasData) {
      orderNo.addAll(data.orderNoModel);
      print(orderNo.length);
    }
    gettingOrderNo.value = false;
    update();
  }

  void showBottomSheet(ResponsiveUI ui) {
    getOrders();
    Get.bottomSheet(BottomSheet(
      builder: (index) {
        return SizedBox(
          height: ui.heightPercent(45),
          child: Padding(
            padding: EdgeInsets.all(ui.widthPercent(3)),
            child: Column(
              children: [
                Text(
                  'Choose Order Number',
                  style: Styles.getstyle(
                      fontweight: FontWeight.bold,
                      fontcolor: ColorPallets.themeColor2),
                ),
                Divider(),
                Expanded(
                  child: Obx(() {
                    if (gettingOrderNo.value) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProgressIndicatorWidget(),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: orderNo.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shadowColor: ColorPallets.fadegrey2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  ui.widthPercent(6),
                                ),
                                side: BorderSide(
                                    color: ColorPallets.themeColor2)),
                            child: ListTile(
                              leading: Text(
                                '${index + 1}.',
                                style: Styles.getstyle(
                                    fontweight: FontWeight.bold,
                                    fontcolor: ColorPallets.themeColor2),
                              ),
                              title: Text(
                                orderNo[index].uniqueNo.toString(),
                                style: Styles.getstyle(
                                    fontweight: FontWeight.bold,
                                    fontcolor: ColorPallets.themeColor),
                              ),
                              onTap: () {
                                orderNumber.text =
                                    orderNo[index].uniqueNo.toString();
                                orderID.value = orderNo[index].id.toString();
                                Get.back();
                              },
                            ),
                          );
                        },
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        );
      },
      onClosing: () {},
    ));
  }

  void clearData() {
    orderNumber.clear();
    orderID.value = '';
    complaintReason.value = '';
    message.clear();
    local_image.value = '';
    update();
  }
}
