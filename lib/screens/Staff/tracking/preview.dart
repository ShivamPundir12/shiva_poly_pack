import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/camera.dart';
import 'package:shiva_poly_pack/data/controller/preview_cntrl.dart';
import 'package:shiva_poly_pack/material/styles.dart';

class ImagePreviewScreen extends GetView<UploadPictureController> {
  final String initialImagePath;

  ImagePreviewScreen({Key? key, required this.initialImagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set the initial image path

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        leading: IconButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.topRight,
              fit: StackFit.loose,
              children: [
                Center(
                  child: Obx(() {
                    if (controller.imagePath.value.isNotEmpty) {
                      return Image.file(
                        File(controller.imagePath.value),
                        fit: BoxFit.contain,
                      );
                    } else {
                      return const Text('No image selected.');
                    }
                  }),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        controller.date.padRight(2, '0').toString() +
                            '\n${controller.time}',
                        style: Styles.getstyle(fontweight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => controller.retake(context),
                icon: const Icon(Icons.camera_alt),
                label: const Text('Retake'),
              ),
              ElevatedButton.icon(
                onPressed: () => controller.uploadImage(),
                icon: const Icon(Icons.cloud_upload),
                label: const Text('Upload'),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
