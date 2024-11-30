import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:shiva_poly_pack/screens/onboardings/onboarding_1.dart';
import 'package:shiva_poly_pack/screens/onboardings/welcome.dart';

class AppRouter {
  static final List<GetPage> pages = [
    GetPage(
        name: Routes.welcome_screen,
        page: () => const WelcomeScreen(),
        transition: Transition.zoom),
    GetPage(
        name: Routes.app,
        page: () => const Onboarding_1(),
        transition: Transition.rightToLeft),
  ];
}

class Routes {
  static String welcome_screen = '/onboardings/welcome';
  static String app = '/onboardings/onboarding_1';
}
