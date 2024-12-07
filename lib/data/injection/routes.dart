import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/camera.dart';
import 'package:shiva_poly_pack/data/controller/follow_up.dart';
import 'package:shiva_poly_pack/data/controller/onboarding.dart';
import 'package:shiva_poly_pack/data/controller/preview_cntrl.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(OnboardingController());
    Get.put(UploadPictureController());
    Get.put(ImageController());
    Get.put(FollowUp());
  }
}
