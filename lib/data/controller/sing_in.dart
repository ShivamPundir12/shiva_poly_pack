import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/account_type.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/data/model/login.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/styles.dart';
import 'package:shiva_poly_pack/routes/app_routes.dart';

import '../../material/indicator.dart';

class SingInController extends GetxController {
  final contactController = TextEditingController();
  final otpController = TextEditingController();
  final formKey = GlobalKey<FormState>().obs;
  final otpFormKey = GlobalKey<FormState>().obs;
  RxBool isStaff = false.obs;
  RxBool isTapped = false.obs;
  ApiService _apiService = ApiService();

  Future<void> goToOtp() async {
    if (formKey.value.currentState!.validate()) {
      if (contactController.value.text.isNotEmpty) {
        sendRequest();
        // Get.offNamed(Routes.otp, preventDuplicates: true);
      }
    }
  }

  Future<void> ontapped() async {
    isTapped.value = true;
    update();
  }

  Future<void> sendRequest() async {
    LoadingView.show();
    final request = await LoginRequest(
      phonenumber: contactController.text,
      isStaff: true,
    );
    await _apiService.login(request).then((v) async {
      if (v?.token != null) {
        await LocalStorageManager.saveData('token', v?.token.toString());
        await LocalStorageManager.saveData('userId', v?.user.id.toString());
        Get.offNamedUntil(Routes.otp, (route) => false);
        LoadingView.hide();
      } else {
        LoadingView.hide();
        Get.snackbar(
            backgroundColor: ColorPallets.themeColor2,
            'Info',
            'This number is not registered to our services!',
            colorText: ColorPallets.white);
      }
    });
  }

  Future<void> goToType() async {
    if (otpFormKey.value.currentState!.validate()) {
      if (otpController.value.text == '1234') {
        // await sendRequest();
        Get.offNamed(Routes.m_pin, preventDuplicates: true);
      } else {
        Get.snackbar(
          'Error',
          'Please enter the correct OTP!',
          colorText: ColorPallets.white,
          messageText: Text(
            'Please enter the correct OTP!',
            style: Styles.getstyle(
              fontcolor: ColorPallets.white,
              fontweight: FontWeight.bold,
              fontsize: 18,
            ),
          ),
          backgroundColor: ColorPallets.themeColor2,
          titleText: Text(
            'Error',
            style: Styles.getstyle(
              fontcolor: Colors.red,
              fontweight: FontWeight.bold,
              fontsize: 16,
            ),
          ),
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Please enter the OTP!',
        colorText: ColorPallets.white,
        messageText: Text(
          'Please enter the OTP!',
          style: Styles.getstyle(
            fontcolor: ColorPallets.white,
            fontweight: FontWeight.bold,
            fontsize: 18,
          ),
        ),
        backgroundColor: ColorPallets.themeColor2,
        titleText: Text(
          'Error',
          style: Styles.getstyle(
            fontcolor: Colors.red,
            fontweight: FontWeight.bold,
            fontsize: 16,
          ),
        ),
      );
    }
  }

  // }

  @override
  void onClose() {
    // Dispose of controllers when the Controller is closed
    contactController.dispose();
    update();
    super.onClose();
  }
}
