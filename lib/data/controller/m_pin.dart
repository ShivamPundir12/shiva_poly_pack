import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/data/controller/sing_in.dart';
import 'package:shiva_poly_pack/data/model/login.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/material/styles.dart';
import 'package:shiva_poly_pack/routes/app_routes.dart';

class MPinController extends GetxController {
  final m_pin = TextEditingController();
  final mpinFormKey = GlobalKey<FormState>().obs;
  final SingInController singInController = Get.find<SingInController>();
  // ApiService _apiService = ApiService();

  Future<void> get_Pin() async {
    if (mpinFormKey.value.currentState!.validate()) {
      LoadingView.show();
      Future.delayed(Durations.medium3).then((v) async {
        await LocalStorageManager.saveData('m_pin', m_pin.text);
        LoadingView.hide();
        Get.offNamed(Routes.upload_picture, preventDuplicates: true);
      });
    }
  }

  Future<void> confirmPin() async {
    if (mpinFormKey.value.currentState!.validate()) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();

      final phoneNo = _prefs.getString('mobile_no') ?? '';
      print(phoneNo);
      final request = await LoginRequest(phonenumber: phoneNo, isStaff: true);
      LoadingView.show();
      Future.delayed(Durations.medium3).then((v) async {
        final pin = await LocalStorageManager.readData('m_pin');
        if (m_pin.text == pin) {
          LoadingView.hide();
          await Get.offNamed(Routes.upload_picture, preventDuplicates: true);
        } else {
          LoadingView.hide();
          Get.snackbar(
            'Opps',
            'Wrong MPIN, Please try again!',
            backgroundColor: ColorPallets.themeColor2,
            colorText: ColorPallets.white,
            titleText: Text(
              'Opps',
              style: Styles.getstyle(
                fontsize: 16,
                fontweight: FontWeight.bold,
                fontcolor: Colors.redAccent,
              ),
            ),
          );
        }
      });
      // await _apiService.login(request).then((v) {
      //   if (v?.token != null) {

      //   } else {
      //     LoadingView.hide();
      //     Get.dialog(AlertDialog(
      //       title: Text('Error'),
      //       content: Text('Session Expired Please login again!'),
      //       actions: [
      //         ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: ColorPallets.themeColor,
      //           ),
      //           onPressed: () {
      //             Get.offNamedUntil(Routes.sigin, (r) => false);
      //           },
      //           child: Text(
      //             'Login',
      //             style: Styles.getstyle(fontcolor: ColorPallets.white),
      //           ),
      //         ),
      //       ],
      //     ));
      //   }
      // });
    } else {
      Get.snackbar(
        'Error',
        'Please enter the MPIN!',
        colorText: ColorPallets.white,
        messageText: Text(
          'Please enter the MPIN!',
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

  @override
  void onClose() {
    super.onClose();
    m_pin.dispose();
  }
}
