import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:shiva_poly_pack/screens/Customer/home/dasboard.dart';
import 'package:shiva_poly_pack/screens/Customer/home/ledger.dart';
import 'package:shiva_poly_pack/screens/Customer/onboardings/account_type.dart';
import 'package:shiva_poly_pack/screens/Customer/onboardings/splash_screen.dart';
import 'package:shiva_poly_pack/screens/Customer/profile/profile.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/pages/final_customer.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/qr_scanner.dart';
import 'package:shiva_poly_pack/screens/auth/m_pin.dart';
import 'package:shiva_poly_pack/screens/auth/m_pin_auth.dart';
import 'package:shiva_poly_pack/screens/auth/otp.dart';
import 'package:shiva_poly_pack/screens/auth/sing_in.dart';
import 'package:shiva_poly_pack/screens/Customer/onboardings/onboarding_1.dart';
import 'package:shiva_poly_pack/screens/Customer/onboardings/welcome.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/camera.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/camera_preview.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/pages/add_new_customer.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/pages/crm_list.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/pages/follow_up.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/pages/new_leads.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/pages/pending_file.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/preview.dart';

class AppRouter {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.welcome_screen,
      page: () => const WelcomeScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.app,
      page: () => Onboarding_1(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.sigin,
      page: () => const SignIn(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.upload_picture,
      page: () => UploadPictureScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.preview_image,
      page: () => ImagePreviewScreen(
        initialImagePath: '',
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.camera_screen,
      page: () => CameraScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.follow_up,
      page: () => FollowUpScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.new_leads,
      page: () => NewLeads(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.pending_files,
      page: () => PendingFile(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.add_new_cus,
      page: () => AddCustomerScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.crm_list,
      page: () => CRMListScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.otp,
      page: () => Otp(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.m_pin,
      page: () => MPin(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.final_cus,
      page: () => FinalCustomer(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.account_typ,
      page: () => AccountSelection(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.check_m_pin,
      page: () => CheckMpin(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.cus_dasboard,
      page: () => DashboardScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.cus_profile,
      page: () => ProfileScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.ledger_report,
      page: () => LedgerReportScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.qr_scanner,
      page: () => QRScannerScreen(),
      transition: Transition.rightToLeft,
    ),
  ];
}

class Routes {
  static String welcome_screen = '/onboardings/welcome';
  static String app = '/onboardings/onboarding_1';
  static String splash = '/onboardings/splash';
  static String sigin = '/auth/sig_in';
  static String m_pin = '/auth/m_pin';
  static String check_m_pin = '/auth/check_m_pin';
  static String otp = '/auth/otp';
  static String upload_picture = '/tracking/camera';
  static String preview_image = '/tracking/prev';
  static String camera_screen = '/tracking/camscrn';
  static String follow_up = '/tracking/pages/follow_up';
  static String new_leads = '/tracking/pages/new_leads';
  static String pending_files = '/tracking/pages/pending_files';
  static String add_new_cus = '/tracking/pages/add_new_customer';
  static String crm_list = '/tracking/pages/crm_list';
  static String final_cus = '/tracking/pages/final_cus';
  static String qr_scanner = '/tracking/qr_scanner';
  static String account_typ = '/tracking/pages/account_typ';
  static String cus_dasboard = '/Customer/home/dasboard';
  static String cus_profile = '/Customer/profile';
  static String ledger_report = '/Customer/home/ledger';
}
