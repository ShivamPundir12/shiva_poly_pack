import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';

class QRScannerController extends GetxController {
  MobileScannerController? qrViewController;

  void handleQRCode(String scannedData) async {
    if (await canLaunchUrl(Uri.parse(scannedData))) {
      await launchUrl(Uri.parse(scannedData));
    } else {
      Get.snackbar('Error', 'Could not open the URL: $scannedData');
    }
  }

  void handleQRCodeFromGallery(File imageFile) async {
    try {
      final MobileScannerController scanner = MobileScannerController();
      final BarcodeCapture? scannedData =
          await scanner.analyzeImage(imageFile.path);

      if (scannedData != null) {
        handleQRCode(scannedData.barcodes.first.rawValue ?? '');
      } else {
        Get.snackbar('Error', 'No QR code found in the image');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to decode QR code from image');
    }
  }

  @override
  void onClose() {
    qrViewController?.dispose();
    super.onClose();
  }
}
