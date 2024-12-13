import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shiva_poly_pack/data/controller/sing_in.dart';
import 'package:shiva_poly_pack/data/services/validation.dart';
import 'package:shiva_poly_pack/material/buttons.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';
import 'package:shiva_poly_pack/routes/app_routes.dart';

final defaultPinTheme = PinTheme(
  width: 70,
  height: 70,
  textStyle: TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    backgroundBlendMode: BlendMode.hardLight,
    color: ColorPallets.white,
    border: Border.all(color: ColorPallets.fadegrey),
    borderRadius: BorderRadius.circular(20),
  ),
);

class Otp extends GetView<SingInController> {
  Otp({super.key});

  final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: ColorPallets.themeColor2),
    borderRadius: BorderRadius.circular(8),
  );

  final submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration?.copyWith(
      color: ColorPallets.white,
    ),
  );

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    int _otpCodeLength = 4;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: ColorPallets.white),
      ),
      backgroundColor: ColorPallets.themeColor,
      bottomSheet: Container(
        alignment: Alignment.bottomCenter,
        height: _ui.heightPercent(82),
        decoration: ShapeDecoration(
          color: ColorPallets.white2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(27),
              topLeft: Radius.circular(27),
            ),
          ),
        ),
        width: _ui.screenWidth,
        child: Form(
          key: controller.otpFormKey.value,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(
                  vertical: _ui.heightPercent(4),
                  horizontal: _ui.heightPercent(3),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/logo.svg',
                      height: _ui.heightPercent(6),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Poly ',
                            style: Styles.getstyle(
                                fontsize: 20, fontweight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: 'Packs',
                                style: Styles.getstyle(
                                    fontcolor: ColorPallets.themeColor,
                                    fontsize: 20,
                                    fontweight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: _ui.heightPercent(10),
                              bottom: _ui.heightPercent(4)),
                          child: RichText(
                            text: TextSpan(
                              text: 'Hey there,',
                              style: Styles.getstyle(
                                  fontcolor: ColorPallets.fadegrey,
                                  fontsize: 20,
                                  fontweight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: '\nSign in to continue!',
                                  style: Styles.getstyle(
                                      fontsize: 26,
                                      fontweight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: _ui.widthPercent(0.5),
                                bottom: _ui.heightPercent(1.5)),
                            child: Text(
                              'Enter OTP',
                              style: Styles.getstyle(
                                  fontweight: FontWeight.bold, fontsize: 14),
                            ),
                          ),
                          buildPinPut(),
                          Padding(
                            padding: EdgeInsets.only(
                                left: _ui.widthPercent(3),
                                right: _ui.widthPercent(5),
                                top: _ui.heightPercent(1)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '00:00',
                                  style: Styles.getstyle(
                                      fontweight: FontWeight.w400),
                                ),
                                Text(
                                  'Resend OTP',
                                  style: Styles.getstyle(
                                      fontweight: FontWeight.w600,
                                      fontsize: 14,
                                      fontcolor: ColorPallets.themeColor),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: _ui.widthPercent(5),
                      ),
                      child: InkWell(
                          onTap: () => controller.goToType(),
                          child:
                              reuseable_button(ui: _ui, button_text: 'Verify')),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        width: _ui.screenWidth,
        height: _ui.heightPercent(82),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              fit: StackFit.passthrough,
              children: [
                Container(
                  alignment: Alignment(1, -1),
                  width: _ui.screenWidth,
                  height: _ui.heightPercent(15),
                  child: SvgPicture.asset(
                    'assets/images/signin/curve1.svg',
                    height: _ui.heightPercent(15),
                    width: _ui.widthPercent(20),
                  ),
                ),
                Container(
                  width: _ui.screenWidth,
                  alignment: Alignment(1, -7),
                  child: SvgPicture.asset(
                    'assets/images/signin/curve2.svg',
                    width: _ui.widthPercent(20),
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPinPut() {
    return Pinput(
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      length: 4,
      validator: ValidationService.normalvalidation,
      controller: controller.otpController,
      enabled: true,
      keyboardType: TextInputType.phone,
      onCompleted: (pin) => print(pin),
    );
  }
}
