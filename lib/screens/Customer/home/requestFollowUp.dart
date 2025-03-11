import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/requestfollowUp.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';
import '../../../material/contactOptions.dart';

class ContactScreen extends GetView<RequestfollowupController> {
  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Scaffold(
      backgroundColor: ColorPallets.white,
      appBar: AppBar(
        backgroundColor: ColorPallets.white,
        centerTitle: true,
        title: Text('Request Follow Up',
            style: Styles.getstyle(
                fontweight: FontWeight.bold, fontsize: _ui.widthPercent(5))),
        bottom: PreferredSize(
            preferredSize: Size(_ui.screenWidth, _ui.heightPercent(2)),
            child: Divider()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: SvgPicture.asset(
                'assets/images/help.svg',
                height: _ui.heightPercent(45),
              ),
            ),
            SizedBox(height: _ui.heightPercent(5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ContactOption(
                  icon: Icons.phone,
                  label: 'Call Us',
                  onTap: () {
                    controller.contactUs();
                  },
                ),
                SizedBox(width: 20),
                ContactOption(
                  icon: FontAwesomeIcons.whatsapp,
                  label: 'WhatsApp Us',
                  onTap: () async {
                    controller.whatsAppUs();
                    print('WhatsApp Us tapped');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
