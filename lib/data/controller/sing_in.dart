import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/model/login.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/styles.dart';
import 'package:shiva_poly_pack/routes/app_routes.dart';

class SingInController extends GetxController {
  final contactController = TextEditingController();
  final otpController = TextEditingController();
  final formKey = GlobalKey<FormState>().obs;
  final otpFormKey = GlobalKey<FormState>().obs;
  RxBool isStaff = false.obs;

  Future<void> goToOtp() async {
    if (formKey.value.currentState!.validate()) {
      if (contactController.value.text.isNotEmpty) {
        Get.offNamed(Routes.otp, preventDuplicates: true);
      }
    }
  }

  Future<void> goToType() async {
    if (otpFormKey.value.currentState!.validate()) {
      if (otpController.value.text == '1234') {
        Get.offNamed(Routes.account_typ, preventDuplicates: true);
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
    }
  }

  // }

  @override
  void onClose() {
    // Dispose of controllers when the Controller is closed
    contactController.dispose();
    super.onClose();
  }
}
