import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/account_type.dart';
import 'package:shiva_poly_pack/data/controller/add_new_customer.dart';
import 'package:shiva_poly_pack/data/controller/all_order.dart';
import 'package:shiva_poly_pack/data/controller/camera.dart';
import 'package:shiva_poly_pack/data/controller/complaint.dart';
import 'package:shiva_poly_pack/data/controller/confirmOrder.dart';
import 'package:shiva_poly_pack/data/controller/crm_list.dart';
import 'package:shiva_poly_pack/data/controller/dasboard.dart';
import 'package:shiva_poly_pack/data/controller/final_customer.dart';
import 'package:shiva_poly_pack/data/controller/follow_up.dart';
import 'package:shiva_poly_pack/data/controller/ledgercontroller.dart';
import 'package:shiva_poly_pack/data/controller/loading.dart';
import 'package:shiva_poly_pack/data/controller/m_pin.dart';
import 'package:shiva_poly_pack/data/controller/my_app.dart';
import 'package:shiva_poly_pack/data/controller/new_leads.dart';
import 'package:shiva_poly_pack/data/controller/onboarding.dart';
import 'package:shiva_poly_pack/data/controller/pending_files.dart';
import 'package:shiva_poly_pack/data/controller/preview_cntrl.dart';
import 'package:shiva_poly_pack/data/controller/profile.dart';
import 'package:shiva_poly_pack/data/controller/qr_controller.dart';
import 'package:shiva_poly_pack/data/controller/sing_in.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      MyAppController(),
      permanent: true,
    );
    Get.put(SingInController());
    Get.put(MPinController());
    Get.put(NewLeadsController());
    Get.put(FinalCustomerController());
    Get.put(PendingFilesController());
    Get.put(OnboardingController());
    Get.put(UploadPictureController());
    Get.put(ImageController());
    Get.put(FollowUp());
    Get.put(AddCustomerController());
    Get.put(CRMListController());
    Get.put(LoadingController());
    Get.put(LedgerReportController());
    Get.put(QRScannerController());
    Get.put(DasboardController());
    Get.put(AccountTypeController());
    Get.put(ConfirmorderController());
    Get.put(AllOrderController());
    Get.put(ComplaintController());
    Get.put(ProfileController());
    Get.put(WebViewController());
  }
}
