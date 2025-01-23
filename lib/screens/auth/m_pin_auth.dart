import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shiva_poly_pack/data/controller/m_pin.dart';
import 'package:shiva_poly_pack/data/controller/sing_in.dart';
import 'package:shiva_poly_pack/data/services/validation.dart';
import 'package:shiva_poly_pack/material/buttons.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';

final defaultPinTheme = PinTheme(
  padding: EdgeInsets.only(left: 20),
  width: 80,
  height: 56,
  decoration: BoxDecoration(
      border:
          BorderDirectional(bottom: BorderSide(color: ColorPallets.fadegrey))),
  textStyle: TextStyle(
    fontSize: 20,
    color: Color.fromRGBO(30, 60, 87, 1),
    fontWeight: FontWeight.w600,
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: ColorPallets.fadegrey2),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    color: ColorPallets.themeColor2,
  ),
);

class CheckMpin extends GetView<MPinController> {
  const CheckMpin({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorPallets.white,
      body: Container(
        width: _ui.screenWidth,
        height: _ui.screenHeight,
        child: SingleChildScrollView(
          child: Form(
            key: controller.mpinFormKey.value,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: _ui.heightPercent(40),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/logo.svg',
                        height: _ui.heightPercent(10),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Poly ',
                          style: Styles.getstyle(
                              fontsize: _ui.widthPercent(8),
                              fontweight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: 'Packs',
                              style: Styles.getstyle(
                                fontcolor: ColorPallets.themeColor,
                                fontsize: _ui.widthPercent(8),
                                fontweight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: _ui.heightPercent(30),
                  width: _ui.screenWidth,
                  margin: EdgeInsets.symmetric(horizontal: _ui.widthPercent(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Enter your m-Pin',
                          style: Styles.getstyle(
                              fontsize: _ui.widthPercent(6),
                              fontcolor: ColorPallets.fadegrey,
                              fontweight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: _ui.heightPercent(2),
                      ),
                      buildPinPut()
                    ],
                  ),
                ),
                Container(
                  width: _ui.widthPercent(85),
                  child: InkWell(
                    onTap: () => controller.refreshToken(context),
                    child: reuseable_button(
                      ui: _ui,
                      button_text: 'Sign In',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPinPut() {
    return Pinput(
      pinContentAlignment: Alignment.center,
      controller: controller.m_pin,
      validator: (c) => ValidationService.normalvalidation(c, 'm-Pin'),
      defaultPinTheme: defaultPinTheme,
      length: 4,
      enabled: true,
      keyboardType: TextInputType.phone,
      onCompleted: (pin) => print(pin),
    );
  }
}
