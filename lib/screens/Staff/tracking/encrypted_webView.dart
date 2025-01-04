import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/qr_controller.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../material/styles.dart';

class WebViewScreen extends GetView<QRScannerController> {
  final String initialUrl;

  WebViewScreen({required this.initialUrl});

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    final webController = Get.put(WebViewController());
    webController.loadRequest(Uri.parse(initialUrl));
    controller.loadUrl(initialUrl);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ColorPallets.themeColor2,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Webview',
          style: Styles.getstyle(
              fontweight: FontWeight.bold,
              fontsize: 20,
              fontcolor: ColorPallets.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.refresh_outlined,
              color: ColorPallets.white,
            ),
          )
        ],
      ),
      body: Container(
        height: _ui.screenHeight,
        padding: EdgeInsets.only(top: _ui.screenHeight * 0.1),
        alignment: Alignment.center,
        constraints: BoxConstraints.expand(),
        child: WebViewWidget(controller: controller.webViewController),
      ),
    );
  }
}
