import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/encrypted_webView.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QRScannerController extends GetxController {
  late final MobileScannerController qrController;
  final ImagePicker _picker = ImagePicker();
  late final WebViewController webViewController;
  RxString url = ''.obs;
  RxBool isInitilizing = false.obs;

  @override
  void onInit() {
    super.onInit();
    isInitilizing.value = true;
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((v) {
      webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              ProgressIndicatorWidget();
              print('Loading progress: $progress');
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
            onHttpError: (HttpResponseError error) {
              print('HTTP error: ${error.response?.statusCode}');
            },
            onWebResourceError: (WebResourceError error) {
              print('Web resource error: ${error.description}');
            },
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                print('Blocked navigation to: ${request.url}');
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        );
    });
    Future.delayed(Durations.extralong4).then((v) {
      isInitilizing.value = false;
    });
    update();
  }

  Future<void> loadUrl(String url) async {
    webViewController.loadRequest(Uri.parse(
        url + '&encryption=730ff998-ae08-31634697-b459-737883a27503'));
  }

  QRScannerController() {
    // isInitilizing.value = true;

    qrController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      detectionTimeoutMs: 1500,
    );
  }

  /// Handle detected QR code from the scanner
  Future<void> handleQRCode(String scannedData) async {
    try {
      print("Scanned Data: 1");
      // Log the URL for debugging
      print(
          'Scanned URL: $scannedData&encryption=730ff998-ae08-31634697-b459-737883a27503');
      // Validate the URL
      if (scannedData.isNotEmpty) {
        qrController.stop();
        loadUrl(scannedData +
            '&encryption=730ff998-ae08-31634697-b459-737883a27503');
        // Navigate to the WebView screen with the scanned URL
        Get.off(
          () => WebViewScreen(
              initialUrl: scannedData +
                  '&encryption=730ff998-ae08-31634697-b459-737883a27503'),
        )?.then((v) {});
      } else {
        // If the URL is invalid, show an error message
        Get.snackbar('Error', 'Invalid URL: $scannedData');
      }
    } catch (e) {
      // Handle any exceptions and show an error message
      Get.snackbar('Error', 'Failed to handle QR code: $e');
    }
  }

  /// Handle QR code from an image selected from the gallery
  Future<void> handleQRCodeFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        Get.snackbar('Error', 'No image selected');
        return;
      }

      final BarcodeCapture? scannedData = await qrController.analyzeImage(
        pickedFile.path,
      );

      if (scannedData != null && scannedData.barcodes.isNotEmpty) {
        handleQRCode(scannedData.barcodes.first.rawValue ?? '');
      } else {
        Get.snackbar('Error', 'No QR code found in the image');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to decode QR code from image: $e');
    }
  }

  void stopQRScanner() {
    qrController.stop();
  }

  @override
  void onClose() {
    qrController.stop();
    qrController.dispose();
    super.onClose();
  }
}
