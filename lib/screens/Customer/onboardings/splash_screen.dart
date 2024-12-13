import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/my_app.dart';
import 'package:shiva_poly_pack/material/responsive.dart';

import '../../../material/color_pallets.dart';
import '../../../material/styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyAppController controller = Get.find<MyAppController>();
    ResponsiveUI _ui = ResponsiveUI(context);
    // Start the timer and navigate to HomeScreen
    Timer(const Duration(milliseconds: 1900), () {
      if (controller.route.value.isNotEmpty) {
        Get.offNamed(controller.route.value, preventDuplicates: true);
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: controller.opacity.value,
          duration: Durations.extralong1,
          curve: Curves.easeInBack,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/logo.svg',
                height: _ui.heightPercent(10),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: _ui.heightPercent(1.6)),
                child: RichText(
                  text: TextSpan(
                      text: 'Poly ',
                      style: Styles.getstyle(
                        fontsize: _ui.widthPercent(6),
                        fontweight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: 'Packs',
                          style: Styles.getstyle(
                            fontsize: _ui.widthPercent(6),
                            fontweight: FontWeight.w600,
                            fontcolor: ColorPallets.themeColor,
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
