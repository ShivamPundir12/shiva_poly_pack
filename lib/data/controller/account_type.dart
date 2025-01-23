import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/data/controller/sing_in.dart';
import 'package:shiva_poly_pack/data/model/login.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/routes/app_routes.dart';

class AccountTypeController extends GetxController {
  RxBool isStaff = false.obs;
  RxBool isCustomer = false.obs;
  late var request;

  Future<void> choosed_type({required bool customerLogin}) async {
    if (customerLogin) {
      isCustomer.value = true;
      isStaff.value = false;
      // request = await LoginRequest(
      //   phonenumber: _singInController.contactController.text,
      //   isStaff: isStaff.value,
      // );
      update();
    } else {
      isStaff.value = true;
      isCustomer.value = false;
      // request = await LoginRequest(
      //     phonenumber: _singInController.contactController.text,
      //     isStaff: isStaff.value);
      update();
    }
  }

  // Future<void> sendRequest() async {
  //   await _apiService.login(request).then((v) async {
  //     if (v?.token != null) {
  //       SharedPreferences _prefs = await SharedPreferences.getInstance();
  //       await LocalStorageManager.saveData('token', v?.token.toString());
  //       _prefs.setString('storedtoken', v?.token.toString() ?? '');
  //       await LocalStorageManager.saveData('userId', v?.user.id.toString());
  //       Get.offNamedUntil(Routes.m_pin, (route) => false);
  //       LoadingView.hide();
  //     }
  //   });
  // }

  Future<void> navigation() async {
    if (isStaff.value) {
      LoadingView.show();
      Get.offNamed(Routes.sigin);
      // await choosed_type(customerLogin: false);
    } else {
      // Get.snackbar('Info',
      //     'Customer Portal is under progress! \nwill be available soon.');
      LoadingView.show();
      Get.offNamed(Routes.sigin);
    }
    LocalStorageManager.saveData('isStaff', isStaff.value);
  }
}
