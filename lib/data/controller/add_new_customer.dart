import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/data/model/new_customer.dart';
import 'package:shiva_poly_pack/data/model/tag_list.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';

class AddCustomerController extends GetxController {
  // Text Editing Controllers for form fields
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final altContactController = TextEditingController();
  final locationController = TextEditingController();
  final followUpDateController = TextEditingController();
  final remarksController = TextEditingController();
  final bussinessController = TextEditingController();
  final tagsController = TextEditingController();
  final agentController = TextEditingController();

  // Observables for dropdown fields
  var selectedBusinessType = RxnString(); // Nullable String
  var selectedTag = RxnString();
  var selectedAgent = RxnString();
  var tagList = <Tag>[].obs;
  var businesstagList = <Tag>[].obs;
  final RxInt selectedTagId = 0.obs;
  final RxInt selectedBTagId = 0.obs;
  final RxInt selectedATagId = 0.obs;
  ApiService _apiService = ApiService();

  // Date Picker Logic
  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      followUpDateController.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  // Function to save form data
  Future<void> saveCustomer() async {
    // Form submission logic (replace with API calls or database saving logic)
    if (nameController.text.isEmpty || contactController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all required fields",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final request = CreateNewCustomer(
        name: nameController.text,
        phoneNumber: contactController.text,
        alternateNumber: altContactController.text,
        location: locationController.text,
        tagsId: selectedTagId.value.toString(),
        businessTypeTagsId: selectedBTagId.value.toString(),
        agentId: 0,
        userId: LocalStorageManager.getUserId(),
        additionalNote: remarksController.text);

    await _apiService.createNewCustomer(request, getToken());

    // Display success message
    Get.snackbar("Success", "Customer Added Successfully",
        backgroundColor: Colors.green, colorText: Colors.white);
    clearController();

    // Debugging form values
    print("Name: ${nameController.text}");
    print("Contact: ${contactController.text}");
    print("Business Type: ${selectedBusinessType.value}");
    print("Tag: ${selectedTag.value}");
    print("Agent: ${selectedAgent.value}");
    print("Follow-up Date: ${followUpDateController.text}");
    print("Remarks: ${remarksController.text}");
  }

  Future<TagListResponse> getTagListData() async {
    final tags = await _apiService.fetchTag(getToken());
    tagList.value = tags.data;
    update();
    return tags;
  }

  Future<TagListResponse> getBussinessTagListData() async {
    final tags = await _apiService.fetchBussinessTag(getToken());
    businesstagList.value = tags.data;
    update();
    return tags;
  }

  void onTagSelected(int tagId, bool isBussiness) {
    if (!isBussiness) {
      selectedTagId.value = tagId;
    } else {
      selectedBTagId.value = tagId;
    }
    print("Selected Tag ID: $tagId");
  }

  void onTagNameSelected(String tag, bool isBussiness) {
    if (isBussiness) {
      bussinessController.text = tag;
    } else {
      tagsController.text = tag;
      agentController.text = tag;
    }
    update();
    print("Selected Tag name: $tag");
  }

  void clearController() {
    nameController.clear();
    contactController.clear();
    contactController.clear();
    altContactController.clear();
    bussinessController.clear();
    tagsController.clear();
    agentController.clear();
    followUpDateController.clear();
    remarksController.clear();
  }

  @override
  void onClose() {
    // Dispose of controllers when the Controller is closed
    nameController.dispose();
    contactController.dispose();
    altContactController.dispose();
    locationController.dispose();
    followUpDateController.dispose();
    remarksController.dispose();
    super.onClose();
  }
}
