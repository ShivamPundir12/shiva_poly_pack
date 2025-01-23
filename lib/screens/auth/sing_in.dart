import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:pinput/pinput.dart';
import 'package:shiva_poly_pack/data/controller/sing_in.dart';
import 'package:shiva_poly_pack/data/services/validation.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';
import 'package:shiva_poly_pack/routes/app_routes.dart';

import '../../material/buttons.dart';

class SignIn extends GetView<SingInController> {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    FocusNode focusNode = FocusNode();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorPallets.themeColor,
      bottomSheet: Container(
        alignment: Alignment.bottomCenter,
        decoration: ShapeDecoration(
          color: ColorPallets.white2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(27),
              topLeft: Radius.circular(27),
            ),
          ),
        ),
        height:
            isKeyboardVisible ? _ui.heightPercent(89) : _ui.heightPercent(82),
        width: _ui.screenWidth,
        child: Obx(
          () => Form(
            key: controller.formKey.value,
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
                            margin: EdgeInsets.only(top: _ui.heightPercent(10)),
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
                        margin: EdgeInsets.only(top: _ui.heightPercent(5)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(left: _ui.widthPercent(1)),
                              child: Text(
                                'Enter your Mobile number',
                                style: Styles.getstyle(
                                  fontweight: FontWeight.bold,
                                  fontcolor: ColorPallets.fadegrey2,
                                  fontsize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: _ui.heightPercent(1.2),
                            ),
                            TextFormField(
                              maxLength: 10,
                              controller: controller.contactController,
                              onTap: controller.ontapped,
                              // focusNode: focusNode,
                              onChanged: (value) {
                                print('object');
                              },
                              validator: ValidationService.validateMobileNumber,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                fillColor: ColorPallets.white,
                                filled: true,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 3),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0),
                                        child: Text(
                                          '+91',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: ColorPallets.fadegrey,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        width: 2, // Set width for the divider
                                        height: _ui.heightPercent(
                                            7), // Height to match input field
                                        color: ColorPallets.fadegrey
                                            .withOpacity(0.5), // Divider color
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                ),
                                hintText: '0 0 0 - 1 1 1 - 2 2 2 2',
                                hintStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 22.0,
                                  horizontal: 12.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.redAccent),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.redAccent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: _ui.heightPercent(4),
                      ),
                      InkWell(
                        onTap: () => controller.goToOtp(),
                        child: reuseable_button(
                          ui: _ui,
                          button_text: 'Get OTP',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
            Row(
              children: [
                Stack(
                  fit: StackFit.passthrough,
                  children: [
                    if (Navigator.canPop(context))
                      IconButton(
                        padding: EdgeInsets.only(top: _ui.heightPercent(5)),
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: ColorPallets.white,
                        ),
                      ),
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
          ],
        ),
      ),
    );
  }
}
