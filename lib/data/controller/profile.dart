import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/data/model/login.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';
import 'package:shiva_poly_pack/material/indicator.dart';

class ProfileController extends GetxController {
  RxBool onedit = false.obs;
  final username = TextEditingController();
  final alternatePhoneno = TextEditingController();
  final phoneNo = TextEditingController();
  final location = TextEditingController();
  GlobalKey<FormState> fromkey = GlobalKey<FormState>();
  RxString image_url = ''.obs;
  RxString local_image = ''.obs;
  ApiService _apiService = ApiService();
  String url = 'http://api.spolypack.com/';
  RxBool isLoading = true.obs;

  final ImagePicker _picker = ImagePicker();

  // Initial values to compare
  String initialUsername = '';
  String initialPhoneNo = '';
  String initialAlternatePhoneno = '';
  String initialLocation = '';
  String initialImage = '';

  void onEdit() {
    if (!onedit.value) {
      onedit.value = true;
      update();
      Get.snackbar('Info', 'Now you can edit the fields');
    }
  }

  Future<ProfileResponse> fetchProfile() async {
    final data = await _apiService.fetchUserProfile(getToken());

    if (data.data.id != 0) {
      username.text = data.data.name;
      phoneNo.text = data.data.phoneNumber;
      alternatePhoneno.text = data.data.alternateNumber ?? '';
      location.text = data.data.location;
      image_url.value = data.data.customerImage ?? '';
      // Storing the initial values for comparison
      initialUsername = data.data.name;
      initialPhoneNo = data.data.phoneNumber;
      initialAlternatePhoneno = data.data.alternateNumber ?? '';
      initialLocation = data.data.location;
      initialImage = data.data.customerImage ?? '';
      update();
    }
    isLoading.value = false;
    return data;
  }

  Future<void> updateProfile() async {
    LoadingView.show();
    if (fromkey.currentState!.validate()) {
      final data = await _apiService.editProfile(
        token: getToken(),
        profile: local_image.isNotEmpty ? File(local_image.value) : null,
        phoneNo: phoneNo.text,
        name: username.text,
        alternateNumber: alternatePhoneno.text,
        location: location.text,
        crmId: int.parse(
          LocalStorageManager.getUserId(),
        ),
      );
      LoadingView.hide();
      Get.snackbar('Info', data);
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      local_image.value = pickedFile.path;
      update();
      Get.snackbar('Success', 'Profile picture selected successfully');
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  // Function to check if any data has changed
  bool _isDataChanged() {
    return username.text != initialUsername ||
        phoneNo.text != initialPhoneNo ||
        alternatePhoneno.text != initialAlternatePhoneno ||
        location.text != initialLocation ||
        local_image.value != initialImage;
  }
}
