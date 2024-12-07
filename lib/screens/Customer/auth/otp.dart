import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';

class Otp extends StatelessWidget {
  const Otp({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    int _otpCodeLength = 4;

    return Scaffold(
      backgroundColor: ColorPallets.themeColor,
      bottomSheet: Container(
        height: _ui.heightPercent(82),
        width: _ui.screenWidth,
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
                        margin: EdgeInsets.symmetric(
                            vertical: _ui.heightPercent(10)),
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
                                    fontsize: 26, fontweight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35, left: 16),
                    // child: 
                    // TextFieldPin(
                    //   alignment: MainAxisAlignment.start,
                    //   textController: TextEditingController(),
                    //   autoFocus: true,
                    //   codeLength: _otpCodeLength,
                    //   defaultBoxSize: 60.0,
                    //   margin: 6,
                    //   selectedBoxSize: 46.0,
                    //   textStyle: TextStyle(fontSize: 16, color: Colors.black),
                    //   defaultDecoration: BoxDecoration(
                    //     color: Colors.blueGrey.withOpacity(0.2),
                    //     border: Border.all(color: Colors.transparent),
                    //     borderRadius: BorderRadius.circular(15.0),
                    //   ),
                    //   selectedDecoration: BoxDecoration(
                    //     color: Colors.blueGrey.withOpacity(0.2),
                    //     border: Border.all(color: Colors.transparent),
                    //     borderRadius: BorderRadius.circular(15.0),
                    //   ),
                    //   onChange: (code) {
                    //     // _onOtpCallBack(code, true);
                    //   },
                    // ),
                  ),
                ],
              ),
            )
          ],
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
}
