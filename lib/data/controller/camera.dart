import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiva_poly_pack/data/injection/permission.dart';
import 'package:shiva_poly_pack/data/model/tacker.dart';
import 'package:shiva_poly_pack/routes/app_routes.dart';

class UploadPictureController extends GetxController {
  late CameraController cameraController;
  RxBool isCameraInitialized = false.obs;
  RxString imagePath = ''.obs;
  RxString date = ''.obs;
  RxString time = ''.obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;
  final String storageKey = 'photo_metadata';

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  // Initialize Camera
  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.first; // Use first available camera
      cameraController = CameraController(frontCamera, ResolutionPreset.high);
      await cameraController.initialize();
      isCameraInitialized.value = true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to initialize camera: $e');
    }
  }

  Future<void> navigate({required String card_name}) async {
    switch (card_name) {
      case 'New Leads':
        break;
      case 'Pending Files':
        break;
      case 'Follow Ups':
        Get.toNamed(Routes.follow_up);
        break;
      case 'Add New Customer':
        break;
      case 'List':
        break;
      case 'Final Customer':
        break;
      default:
    }
  }

  Future<void> retake(BuildContext context) async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    Get.back(canPop: true, closeOverlays: true);
  }

  Future<void> navigatetoCamera() async {
    await Get.toNamed(Routes.camera_screen);
  }

  // Capture Photo
  Future<void> capturePhoto(BuildContext context) async {
    showDialog(
        context: context,
        builder: (c) {
          return Container(
            alignment: Alignment.center,
            height: 50,
            width: 50,
            child: CircularProgressIndicator.adaptive(),
          );
        });
    try {
      final file = await cameraController.takePicture();
      imagePath.value = file.path;

      // Get Current Date and Time
      final now = DateTime.now();

// Format date as DD-MM-YYYY with single-digit padding
      date.value = DateFormat('dd-MM-yyyy').format(now);

// Format time as hh:mm:ss a (12-hour format with AM/PM)
      time.value = DateFormat('hh:mm:ss a').format(now);

      // Get Location
      final position = await Geolocator.getCurrentPosition();
      latitude.value = position.latitude.toString();
      longitude.value = position.longitude.toString();

      // Save Metadata
      final metadata = PhotoMetadata(
        imagePath: imagePath.value,
        date: date.value,
        time: time.value,
        latitude: latitude.value,
        longitude: longitude.value,
      );
      // Navigator.pop(context);
      print('metadata $metadata');
      await saveMetadata(metadata);
    } catch (e) {
      Get.snackbar('Error', 'Failed to capture photo: $e');
    }
  }

  void uploadImage() {
    if (imagePath.value.isEmpty) {
      Get.snackbar('No Image Selected', 'Please select an image first!',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Your upload logic goes here
    Get.defaultDialog(
      title: 'Upload',
      middleText: 'Image uploaded successfully!',
      textConfirm: 'OK',
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }

  // Save Metadata to Local Storage
  Future<void> saveMetadata(PhotoMetadata metadata) async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString(storageKey) ?? '[]';
    final List<dynamic> jsonList = jsonDecode(storedData);
    jsonList.add(metadata.toJson());
    await prefs.setString(storageKey, jsonEncode(jsonList));
    Get.toNamed(Routes.preview_image);
    Get.snackbar('Success', 'Photo Clicked Successfully');
  }

  // Load All Saved Metadata
  Future<List<PhotoMetadata>> loadMetadata() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString(storageKey) ?? '[]';
    final List<dynamic> jsonList = jsonDecode(storedData);
    return jsonList.map((e) => PhotoMetadata.fromJson(e)).toList();
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}
