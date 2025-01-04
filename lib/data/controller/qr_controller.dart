import 'package:get/get.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/encrypted_webView.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QRScannerController extends GetxController {
  late final MobileScannerController qrController;
  final ImagePicker _picker = ImagePicker();
  late final WebViewController webViewController;
  RxString url = ''.obs;

  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
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
  }

  void loadUrl(String url) {
    webViewController.loadRequest(Uri.parse(url));
  }

  QRScannerController() {
    qrController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
    );
  }

  /// Handle detected QR code from the scanner
  Future<void> handleQRCode(String scannedData) async {
    try {
      final Uri url = Uri.parse(scannedData);

      // Log the URL for debugging
      print('Scanned URL: $url');

      // Validate the URL
      if (url.scheme == 'http' || url.scheme == 'https') {
        // Navigate to the WebView screen with the scanned URL
        Get.to(() => WebViewScreen(initialUrl: scannedData));
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

  @override
  void onClose() {
    qrController.dispose();
    super.onClose();
  }
}
