import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import '../../../data/controller/qr_controller.dart';

class QRScannerScreen extends GetView<QRScannerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: AiBarcodeScanner(
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.noDuplicates,
              ),
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
                // Example validation logic
                if (capture.barcodes.isEmpty) return false;
                return true; // Accept all scanned barcodes
              },
              onDispose: () {
                debugPrint("Barcode scanner disposed!");
              },
              // customOverlayBuilder: (p0, p1, p2) => Container(
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: Colors.red,
              //       width: 3,
              //     ),
              //   ),
              //   child: Center(
              //     child: Text(
              //       "Scanning...",
              //       style: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
