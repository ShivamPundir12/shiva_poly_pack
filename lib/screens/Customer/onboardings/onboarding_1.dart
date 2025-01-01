import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/data/controller/onboarding.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';
import 'package:shiva_poly_pack/routes/app_routes.dart';
import 'package:shiva_poly_pack/screens/Customer/onboardings/material/dots.dart';

class Onboarding_1 extends GetView<OnboardingController> {
  const Onboarding_1({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: (index) {
                  controller.updateIndex(index);
                },
                children: [
                  buildPage(
                    height: 22,
                    text1: 'YOUR ',
                    text2: 'PACAKGE',
                    fontcolor2: ColorPallets.themeColor,
                    text3: '\n YOUR WAY',
                    text4: '\n Track your order from start to finish.',
                    ui: _ui,
                    image: 'assets/images/onboardings/onboarding1.svg',
                    fontsize: _ui.heightPercent(3.5),
                  ),
                  buildPage(
                    height: 25,
                    text1: 'REAL-TIME ',
                    fontcolor: ColorPallets.themeColor,
                    text2: 'UPDATES, ',
                    text3: '\nRIGHT AT YOUR FINGERTIPS',
                    text4:
                        '\n Know the exact status of your order,\n anytime, anywhere.',
                    ui: _ui,
                    image: 'assets/images/onboardings/onboarding2.svg',
                    fontsize: _ui.heightPercent(2.6),
                  ),
                  buildPage(
                    height: 22,
                    padding: 35,
                    text1: 'YOUR ',
                    text2: 'SATISFACTION',
                    fontcolor2: ColorPallets.themeColor,
                    text3: '\n OUR PRIORTY',
                    text4:
                        "\n We're committed to providing the best \n  packaging solutions and service.",
                    ui: _ui,
                    image: 'assets/images/onboardings/onboarding3.svg',
                    fontsize: _ui.heightPercent(3.2),
                  ),
                ],
              ),
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.only(bottom: _ui.heightPercent(7)),
                child: DotIndicator(
                  itemCount: 3,
                  currentIndex: controller.currentIndex.value,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: ColorPallets.themeColor,
        onPressed: () {
          if (controller.currentIndex < 2) {
            controller.pageController
                .nextPage(duration: Durations.long1, curve: Curves.decelerate);
          } else {
            LocalStorageManager.saveData('onboard-done', 'yes');
            Get.offNamedUntil(Routes.welcome_screen, (routes) => false);
          }
        },
        child: SvgPicture.asset('assets/icons/next.svg'),
      ),
    );
  }

  Widget buildPage({
    required ResponsiveUI ui,
    required String image,
    required String text1,
    required String text2,
    required String text3,
    required String text4,
    required double height,
    double? padding,
    Color? fontcolor,
    Color? fontcolor2,
    required double fontsize,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: ui.heightPercent(33),
          margin: padding != null ? EdgeInsets.only(top: padding) : null,
          alignment: Alignment.bottomCenter,
          child: SvgPicture.asset(image),
        ),
        Container(
          height: ui.heightPercent(height),
          width: ui.screenWidth,
          margin: EdgeInsets.only(
            left: ui.widthPercent(5),
            top: ui.heightPercent(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  text: text1,
                  style: Styles.getstyle(
                    fontsize: ui.heightPercent(3.7),
                    fontcolor: fontcolor,
                    fontweight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: text2,
                      style: Styles.getstyle(
                        fontsize: ui.heightPercent(3.5),
                        fontcolor: fontcolor2,
                        fontweight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: text3,
                      style: Styles.getstyle(
                        fontsize: fontsize,
                        fontweight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: text4,
                      style: Styles.getstyle(
                        fontsize: ui.heightPercent(2),
                        fontcolor: ColorPallets.fadegrey2,
                        fontweight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
