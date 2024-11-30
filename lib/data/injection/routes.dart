import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/onboarding.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(OnboardingController());
  }
}
