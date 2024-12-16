import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/account_type.dart';
import 'package:shiva_poly_pack/data/controller/add_new_customer.dart';
import 'package:shiva_poly_pack/data/controller/camera.dart';
import 'package:shiva_poly_pack/data/controller/crm_list.dart';
import 'package:shiva_poly_pack/data/controller/follow_up.dart';
import 'package:shiva_poly_pack/data/controller/loading.dart';
import 'package:shiva_poly_pack/data/controller/m_pin.dart';
import 'package:shiva_poly_pack/data/controller/my_app.dart';
import 'package:shiva_poly_pack/data/controller/new_leads.dart';
import 'package:shiva_poly_pack/data/controller/onboarding.dart';
import 'package:shiva_poly_pack/data/controller/pending_files.dart';
import 'package:shiva_poly_pack/data/controller/preview_cntrl.dart';
import 'package:shiva_poly_pack/data/controller/sing_in.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      MyAppController(),
      permanent: true,
    );
    Get.put(NewLeadsController());
    Get.put(PendingFilesController());
    Get.put(SingInController());
    Get.put(OnboardingController());
    Get.put(UploadPictureController());
    Get.put(ImageController());
    Get.put(FollowUp());
    Get.put(AddCustomerController());
    Get.put(CRMListController());
    Get.put(AccountTypeController());
    Get.put(LoadingController());
    Get.put(MPinController());
  }
}
