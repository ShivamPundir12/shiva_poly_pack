import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/styles.dart';

class PDFHelper {
  static Future<void> previewAndDownloadPDF({
    required BuildContext context,
    required String url,
    required String fileName,
  }) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      // Download the PDF to a temporary directory for preview
      final tempDir = Directory.systemTemp;
      final tempFilePath = "${tempDir.path}/$fileName";

      // Use HttpClient to download the file
      final HttpClient httpClient = HttpClient();
      final Uri uri = Uri.parse(url);
      final HttpClientRequest request = await httpClient.getUrl(uri);
      final HttpClientResponse response = await request.close();

      // Save the file to the temporary location
      final file = File(tempFilePath);
      final fileSink = file.openWrite();
      await response.pipe(fileSink);
      await fileSink.close();

      // Close the loading dialog
      Navigator.pop(context);

      // Navigate to the PDF preview screen
      if (await _requestStoragePermission(context)) {
        await saveToDownloads(
            context: context, sourcePath: file.path, fileName: fileName);
      }
    } catch (e) {
      // Handle errors
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load PDF: $e")),
      );
    }
  }

  /// Save the PDF to the default Downloads folder
  static Future<void> saveToDownloads({
    required BuildContext context,
    required String sourcePath,
    required String fileName,
  }) async {
    try {
      if (await _requestStoragePermission(context)) {
        final downloadsDir = await getExternalStorageDirectory();
        final downloadsPath = "${downloadsDir!.path}/$fileName";
        final file = File(sourcePath);
        final newFile = await file.copy(downloadsPath);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "File Downloded Successfully",
                style: Styles.getstyle(
                    fontcolor: ColorPallets.white, fontweight: FontWeight.bold),
              )),
        );
        OpenFile.open(newFile.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save file: $e")),
      );
    }
  }

  /// Request storage permission dynamically
  static Future<bool> _requestStoragePermission(BuildContext context) async {
    // Check current permission status
    final status = await Permission.manageExternalStorage.status;

    if (status.isGranted) {
      // Permission already granted
      return true;
    } else if (status.isDenied) {
      // Request permission
      final result = await Permission.manageExternalStorage.request();
      if (result.isGranted) {
        return true;
      } else {
        // Permission denied
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text("Storage permission is required to save the file.")),
        );
        return false;
      }
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, open app settings
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              "Storage permission is permanently denied. Enable it in app settings."),
          action: SnackBarAction(
            label: "Settings",
            onPressed: () {
              openAppSettings();
            },
          ),
        ),
      );
      return false;
    }

    // Default case
    return false;
  }
}
