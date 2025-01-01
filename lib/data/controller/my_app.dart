import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/routes/app_routes.dart';

class MyAppController extends GetxController {
  RxString route = ''.obs;
  RxString onboard = ''.obs;
  RxString m_pin = ''.obs;
  RxDouble opacity = 0.0.obs;

  @override
  void onInit() async {
    super.onInit();
    await GetStorage.init();
    Future.delayed(Durations.medium2).then((c) {
      opacity.value = 1.0;
      update();
    });
    onboard.value = LocalStorageManager.readData('onboard-done') ?? 'no';
    m_pin.value = LocalStorageManager.readData('m_pin') ?? '';
    set_route();
  }

  void set_route() {
    if (onboard.value == 'yes' && m_pin == '') {
      route.value = Routes.welcome_screen;
    } else if (onboard.value == 'no' && m_pin == '') {
      route.value = Routes.app;
    } else {
      route.value = Routes.check_m_pin;
    }
    // _navigateToRoute();
  }

  void _navigateToRoute() {
    // Prevent double navigation
    if (Get.currentRoute != route.value) {
      Get.offNamed(route.value);
    }
  }
}
