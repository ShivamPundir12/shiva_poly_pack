import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';
import 'package:shiva_poly_pack/material/indicator.dart';

import '../../material/styles.dart';

class ComplaintController extends GetxController {
  var orderNumber = ''.obs;
  var orderDate = ''.obs;
  var complaintReason = ''.obs;
  var message = ''.obs;
  RxString local_image = ''.obs;
  ApiService _apiService = ApiService();
  final ImagePicker _picker = ImagePicker();

  List<String> reasons = [
    'Product Quality',
    'Late Delivery',
    'Wrong Item',
    'Others'
  ];

  void setOrderNumber(String value) {
    orderNumber.value = value;
  }

  void setOrderDate(String value) {
    orderDate.value = value;
  }

  void setComplaintReason(String value) {
    complaintReason.value = value;
  }

  void setMessage(String value) {
    message.value = value;
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      local_image.value = pickedFile.path;
      update();
      Get.snackbar('Success', 'Profile picture selected successfully');
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  Future<void> submitComplaint() async {
    LoadingView.hide();
    final data = _apiService.submitComplaint(
      token: getToken(),
      orderNo: int.parse(orderNumber.value),
      complaintReason: complaintReason.value,
      message: message.value,
      crmId: int.parse(
        LocalStorageManager.getUserId(),
      ),
    );
    LoadingView.hide();
    print(data);
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
}
