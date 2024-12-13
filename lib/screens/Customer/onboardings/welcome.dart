import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';
import 'package:shiva_poly_pack/routes/app_routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: _ui.screenWidth,
          height: _ui.screenHeight,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/logo.svg',
                alignment: Alignment.center,
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
              SizedBox(
                height: _ui.heightPercent(6),
              ),
              Container(
                height: _ui.heightPercent(41),
                width: _ui.screenWidth,
                margin: EdgeInsets.only(
                    left: _ui.widthPercent(8), top: _ui.heightPercent(5)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: Styles.getstyle(
                        fontsize: _ui.widthPercent(10),
                        fontweight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: _ui.heightPercent(1.1),
                    ),
                    Text(
                      'Track your Orders',
                      style: Styles.getstyle(
                          fontsize: _ui.widthPercent(6.5),
                          fontcolor: ColorPallets.fadegrey),
                    ),
                    Text(
                      'seamlessly & intuitively',
                      style: Styles.getstyle(
                          fontsize: _ui.widthPercent(6.5),
                          fontweight: FontWeight.w600,
                          fontcolor: ColorPallets.fadegrey2),
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(Routes.sigin),
                      child: Container(
                        height: _ui.heightPercent(12),
                        alignment: Alignment.bottomLeft,
                        child: Chip(
                          backgroundColor: ColorPallets.themeColor,
                          labelPadding: EdgeInsets.symmetric(
                              horizontal: _ui.widthPercent(26),
                              vertical: _ui.heightPercent(0.8)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          label: Text(
                            'Get Started',
                            style: Styles.getstyle(
                                fontsize: _ui.widthPercent(5),
                                fontweight: FontWeight.w800,
                                fontcolor: ColorPallets.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _ui.heightPercent(2),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: _ui.widthPercent(10),
                          top: _ui.heightPercent(3.4)),
                      child: RichText(
                        text: TextSpan(
                          text: 'Privacy Policy ',
                          style: Styles.getstyle(
                              fontsize: _ui.widthPercent(4),
                              fontweight: FontWeight.w700,
                              fontcolor: ColorPallets.themeColor),
                          children: [
                            TextSpan(
                              text: '& ',
                              style: Styles.getstyle(
                                fontsize: _ui.widthPercent(4),
                                fontweight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: 'Term and Condition',
                              style: Styles.getstyle(
                                fontsize: _ui.widthPercent(4),
                                fontweight: FontWeight.w700,
                                fontcolor: ColorPallets.themeColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
