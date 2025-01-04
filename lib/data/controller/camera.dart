import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/data/controller/new_leads.dart';
import 'package:shiva_poly_pack/data/injection/permission.dart';
import 'package:shiva_poly_pack/data/model/tacker.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/routes/app_routes.dart';
import 'package:geocoding/geocoding.dart';

class UploadPictureController extends GetxController {
  late CameraController cameraController;
  RxBool isCameraInitialized = false.obs;
  RxString imagePath = ''.obs;
  RxString date = ''.obs;
  RxString time = ''.obs;
  RxDouble latitude = 0.0.obs;
  RxString locationName = ''.obs;
  RxBool toggledPhoto = true.obs;
  RxBool toggledScanner = false.obs;
  RxDouble longitude = 0.0.obs;
  RxBool isCameraPreviewVisible = true.obs;
  final String storageKey = 'photo_metadata';
  Rx<PhotoMetadata> metadata =
      PhotoMetadata(useerId: '', latitude: 0, longitude: 0, locationName: '')
          .obs;
  ApiService _apiService = ApiService();
  RxList<CameraDescription> cameras = <CameraDescription>[].obs;
  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  Future<void> toggleState(String state) async {
    if (state == 'photo') {
      toggledPhoto.value = true;
      toggledScanner.value = false;
    } else {
      toggledPhoto.value = false;
      toggledScanner.value = true;
    }
    update();
  }

  // Initialize Camera
  Future<void> initializeCamera() async {
    try {
      // Get all available cameras
      final cameras = await availableCameras();

      // Filter to find the back camera
      final backCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => throw Exception('No back camera found'),
      );
      cameraController = CameraController(backCamera, ResolutionPreset.high);
      await cameraController.initialize();
      if (await Permission.camera.request().isDenied) {
        await Permission.camera.request();
      }

      isCameraInitialized.value = true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to initialize camera: $e');
    }
  }

  Future<void> navigate({required String card_name}) async {
    switch (card_name) {
      case 'New Leads':
        Get.toNamed(Routes.new_leads);
        break;
      case 'Pending Files':
        Get.toNamed(Routes.pending_files);
        break;
      case 'Follow Ups':
        Get.toNamed(Routes.follow_up);
        break;
      case 'Add New Customer':
        Get.toNamed(Routes.add_new_cus);
        break;
      case 'List':
        Get.toNamed(Routes.crm_list);
        break;
      case 'Final Customer':
        Get.toNamed(Routes.final_cus);
        break;
      default:
    }
  }

  Future<void> retake(BuildContext context) async {
    Get.back();
  }

  Future<void> navigationSet() async {
    if (toggledPhoto.value) {
      await Get.toNamed(Routes.camera_screen);
    } else {
      await Get.toNamed(Routes.qr_scanner);
    }
  }

  // Switch Camera
  // Future<void> switchCamera() async {
  //   try {
  //     if (cameras.isEmpty) {
  //       Get.snackbar('Error', 'No cameras available');
  //       return;
  //     }

  //     isCameraInitialized.value = false; // Mark initialization as false
  //     isCameraPreviewVisible.value = false; // Hide preview during switch

  //     int currentIndex = cameras.indexWhere(
  //       (camera) =>
  //           camera.lensDirection ==
  //           cameraController.value.description.lensDirection,
  //     );
  //     int nextIndex = (currentIndex + 1) % cameras.length;

  //     final newCamera = cameras[nextIndex];
  //     cameraController.value =
  //         CameraController(newCamera, ResolutionPreset.high);

  //     await cameraController.value.initialize();
  //     isCameraInitialized.value = true;
  //     isCameraPreviewVisible.value = true; // Show preview after switch
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to switch camera: $e');
  //     isCameraInitialized.value = true;
  //     isCameraPreviewVisible.value = true;
  //   }
  // }

  // Capture Photo
  Future<void> capturePhoto(BuildContext context) async {
    LoadingView.show();
    try {
      final file = await cameraController.takePicture();
      imagePath.value = file.path;

      // Get Current Date and Time
      final now = DateTime.now();

      date.value = DateFormat('dd-MM-yyyy').format(now);
      time.value = DateFormat('hh:mm:ss a').format(now);

      // Get Location
      final position = await Geolocator.getCurrentPosition();
      latitude.value = position.latitude;
      longitude.value = position.longitude;

      // Reverse Geocoding to get the location name
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          final Placemark place = placemarks.first;
          locationName.value = place.name.toString() +
              ', ' +
              place.subLocality.toString() +
              ", " +
              place.subAdministrativeArea.toString() +
              ", " +
              place.locality.toString();
          print("Location :-> " + locationName.value);
        }
      } catch (e) {
        print('Error while reverse geocoding: $e');
      }

      // Save Metadata
      metadata.value = PhotoMetadata(
        imagePath: file,
        latitude: latitude.value,
        longitude: longitude.value,
        useerId: LocalStorageManager.getUserId(),
        locationName: locationName.value,
      );

      print('Location Name: $locationName'); // Print the location name
      print('Metadata: $metadata');
      await saveMetadata(metadata.value, context);
    } catch (e) {
      Navigator.pop(context); // Ensure the dialog is closed on error
      Get.snackbar('Error', 'Failed to capture photo: $e');
    }
  }

  Future<void> uploadImage() async {
    if (imagePath.value.isEmpty) {
      Get.snackbar('No Image Selected', 'Please select an image first!',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    await _apiService.createMarket(metadata.value, getToken()).then((v) {
      if (v.data.photoUrl != '') {
        Get.back();
        Get.snackbar(
          "Upload",
          "Image uploaded successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    });
    // Your upload logic goes here
  }

  // Save Metadata to Local Storage
  Future<void> saveMetadata(
      PhotoMetadata metadata, BuildContext context) async {
    Navigator.pop(context);
    Get.toNamed(Routes.preview_image);
    Get.snackbar(
      'Success',
      'Photo Clicked Successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
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
