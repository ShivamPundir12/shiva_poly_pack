import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import '../../../data/controller/qr_controller.dart';

class QRScannerScreen extends GetView<QRScannerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          controller.stopQRScanner();
        },
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Obx(
                () {
                  if (controller.isInitilizing.value) {
                    return Center(
                      child:
                          CircularProgressIndicator(), // Show loading indicator
                    );
                  }
                  return AiBarcodeScanner(
                    successColor: Colors.green,
                    controller: controller.qrController,
                    onDetect: (BarcodeCapture barcodeCapture) {
                      final barcodes = barcodeCapture.barcodes;
                      for (final barcode in barcodes) {
                        final String? code = barcode.rawValue;
                        if (code != null) {
                          controller.handleQRCode(code);
                        }
                      }
                    },
                    validator: (BarcodeCapture capture) {
                      if (capture.barcodes.isEmpty) return false;
                      return true; // Accept all scanned barcodes
                    },
                    onDispose: () {
                      debugPrint("Barcode scanner disposed!");
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
