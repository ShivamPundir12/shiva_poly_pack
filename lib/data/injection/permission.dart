import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shiva_poly_pack/data/controller/camera.dart';

Future<void> requestPermissions(BuildContext context) async {
  final locationStatus = await Permission.location.request();
  final cameraPermission = await Permission.camera.request();
  final micPermission = await Permission.microphone.request();
  if (locationStatus.isDenied) {
    Get.snackbar('Note', 'Location Permission is required');
    await Permission.location.request();
  } else if (locationStatus.isPermanentlyDenied) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Needed'),
          content: const Text(
            'Location access is required to take photos. Please enable it in the app settings.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings(); // Open the app settings
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  if (cameraPermission.isDenied ||
      micPermission.isDenied ||
      cameraPermission.isPermanentlyDenied) {
    Get.snackbar('Note', 'Camera Access Permission is required');
    CameraPermissionHandler.requestCameraPermission(context);
  }
}

class CameraPermissionHandler {
  static Future<void> requestCameraPermission(BuildContext context) async {
    PermissionStatus status = await Permission.camera.status;
    PermissionStatus micStatus = await Permission.microphone.status;
    PermissionStatus bluetoothPermisson = await Permission.bluetooth.status;
    final bluetooth = await Permission.bluetoothConnect.request();

    if (status.isDenied) {
      // If the permission is denied, request it
      status = await Permission.camera.request();
      Get.snackbar('Note', 'Please restart the app to use camera');
    } else if (micStatus.isDenied) {
      micStatus = await Permission.microphone.request();
    }

    if (bluetooth.isDenied) {
      Get.snackbar('Note', 'Bluetooth Permission is required');
      await Permission.bluetoothConnect.request();
    } else if (bluetooth.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Bluetooth Permission Needed'),
            content: const Text(
              'Bluetooth access is required to take photos. Please enable it in the app settings.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  openAppSettings(); // Open the app settings
                },
                child: const Text('Open Settings'),
              ),
            ],
          );
        },
      );
    }

    if (status.isPermanentlyDenied) {
      // If the permission is permanently denied, show a dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Camera Permission Needed'),
            content: const Text(
              'Camera access is required to take photos. Please enable it in the app settings.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  openAppSettings(); // Open the app settings
                },
                child: const Text('Open Settings'),
              ),
            ],
          );
        },
      );
    } else if (status.isGranted) {
      // Permission granted, proceed with accessing the camera
      print("Camera permission granted");

      // Add camera-related logic here
    }
  }
}
