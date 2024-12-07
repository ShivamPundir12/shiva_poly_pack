import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:shiva_poly_pack/screens/Customer/auth/sing_in.dart';
import 'package:shiva_poly_pack/screens/Customer/onboardings/onboarding_1.dart';
import 'package:shiva_poly_pack/screens/Customer/onboardings/welcome.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/camera.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/camera_preview.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/pages/follow_up.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/preview.dart';

class AppRouter {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.welcome_screen,
      page: () => const WelcomeScreen(),
      transition: Transition.zoom,
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
  ];
}

class Routes {
  static String welcome_screen = '/onboardings/welcome';
  static String app = '/onboardings/onboarding_1';
  static String sigin = '/auth/sig_in';
  static String upload_picture = '/tracking/camera';
  static String preview_image = '/tracking/prev';
  static String camera_screen = '/tracking/camscrn';
  static String follow_up = '/tracking/pages/follow_up';
}
