import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../data/controller/qr_controller.dart';

class QRScannerScreen extends GetView<QRScannerController> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_library),
            onPressed: () async {
              try {
                final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  controller.handleQRCodeFromGallery(File(pickedFile.path));
                }
              } catch (e) {
                Get.snackbar('Error', 'Failed to pick image: $e');
              }
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: MobileScanner(
              key: qrKey,
              onDetect: (barcodeCapture) {
                final barcodes = barcodeCapture.barcodes;
                for (final barcode in barcodes) {
                  final String? code = barcode.rawValue;
                  if (code != null) {
                    controller.handleQRCode(code);
                  }
                }
              },
              controller: controller.qrViewController,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Scan a QR code'),
            ),
          ),
        ],
      ),
    );
  }
}