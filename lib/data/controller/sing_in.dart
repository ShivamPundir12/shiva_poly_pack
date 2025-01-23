import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiva_poly_pack/data/controller/account_type.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/data/controller/m_pin.dart';
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
  late final MPinController _mPinController;
  late final AccountTypeController _accountTypeController;

  @override
  void onInit() {
    super.onInit();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((v) {
      _mPinController = Get.put(MPinController());
      _accountTypeController = Get.put(AccountTypeController());
    });
  }

  Future<void> goToOtp() async {
    if (formKey.value.currentState!.validate()) {
      if (contactController.value.text.isNotEmpty) {
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        _prefs.setString('mobile_no', contactController.text);
        await sendRequest(contactController.text);
        // Get.offNamed(Routes.otp, preventDuplicates: true);
      }
    }
  }

  Future<void> ontapped() async {
    isTapped.value = true;
    update();
  }

  Future<void> sendRequest(String contact) async {
    LoadingView.show();
    final request = await LoginRequest(
      phonenumber: contact,
      isStaff: _accountTypeController.isStaff.value,
    );
    await _apiService.login(request).then((v) async {
      if (v?.token != null) {
        await LocalStorageManager.saveData('token', v?.token.toString());
        await LocalStorageManager.saveData(
            'refresh-token', v?.refreshToken.toString());
        await LocalStorageManager.saveData('userId', v?.user?.id.toString());
        Get.offNamedUntil(Routes.otp, (route) => false);
        contactController.clear();
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
        clearController();
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

  void clearController() {
    contactController.clear();
    otpController.clear();
    if (_mPinController.m_pin.text.isNotEmpty) {
      _mPinController.m_pin.clear();
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
