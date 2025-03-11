import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/data/controller/requestInfo.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/indicator.dart';

class RequestfollowupController extends GetxController {
  ApiService _apiService = ApiService();

  Future<void> contactUs() async {
    LoadingView.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phoneNumber = prefs.getString('mobile_no') ?? '';
    String name = LocalStorageManager.readData('user_name');
    await _apiService
        .contactUs(
            token: getToken(), customerName: name, phoneNumber: phoneNumber)
        .then((v) {
      if (v == 200) {
        LoadingView.hide();
        Get.snackbar(
          colorText: ColorPallets.white,
          backgroundColor: ColorPallets.themeColor2,
          duration: Duration(seconds: 5),
          'Info',
          'Thank you for reaching out to us! Our team is already on it and will get back to you within 24 hours. If you have any additional details to share in the meantime, feel free to let us know. We’re here to help!',
        );
      } else {
        LoadingView.hide();
      }
    });
  }

  Future<void> whatsAppUs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phoneNumber = prefs.getString('mobile_no') ?? '';
    String name = LocalStorageManager.readData('user_name');
    WhatsAppService.openWhatsAppChat(
      phoneNumber: "+919988110853",
      userName: name,
      userContactNumber: phoneNumber,
    );
  }
}
