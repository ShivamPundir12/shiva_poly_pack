import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shiva_poly_pack/data/controller/camera.dart';
import 'package:shiva_poly_pack/data/injection/permission.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';

import '../../../material/styles.dart';

class CameraScreen extends GetView<UploadPictureController> {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((v) {
      requestPermissions(context);
    });

    ResponsiveUI _ui = ResponsiveUI(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Camera',
          style: Styles.getstyle(fontweight: FontWeight.bold, fontsize: 26),
        ),
      ),
      body: Container(
        height: _ui.screenHeight,
        width: _ui.screenWidth,
        margin: EdgeInsets.only(
          bottom: _ui.heightPercent(4),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          fit: StackFit.loose,
          children: [
            CameraPreview(controller.cameraController),
            Container(
              child: IconButton(
                padding: EdgeInsets.symmetric(vertical: _ui.heightPercent(3)),
                onPressed: () => controller.capturePhoto(context),
                icon: Icon(
                  Icons.camera,
                  color: ColorPallets.white,
                  size: _ui.heightPercent(8),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
