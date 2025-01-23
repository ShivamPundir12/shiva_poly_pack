import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/data/controller/pending_files.dart';
import 'package:shiva_poly_pack/data/model/new_customer.dart';
import 'package:shiva_poly_pack/data/model/tag_list.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';
import '../../routes/app_routes.dart';

class AddCustomerController extends GetxController {
  // Text Editing Controllers for form fields
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final altContactController = TextEditingController();
  final locationController = TextEditingController();
  final followUpDateController = TextEditingController();
  final remarksController = TextEditingController();
  final bussinessController = TextEditingController().obs;
  final tagsController = TextEditingController().obs;
  final agentController = TextEditingController().obs;
  final cusFormKey = GlobalKey<FormState>().obs;
  RxList<Tag> selectbusinesstagList = <Tag>[].obs;
  RxList<Tag> selectagstagList = <Tag>[].obs;
  RxList<Tag> selectagenTtagList = <Tag>[].obs;

  // Observables for dropdown fields
  var selectedBusinessType = RxnString(); // Nullable String
  var selectedTag = RxnString();
  var selectedAgent = RxnString();
  var tagList = <Tag>[].obs;
  var businesstagList = <Tag>[].obs;
  var agenttagList = <Tag>[].obs;
  final RxList<String> selectedTagId = <String>[].obs;
  final RxList<String> selectedBTagId = <String>[].obs;
  final RxInt selectedATagId = 0.obs;
  final RxInt id = 0.obs;
  final RxBool isSaved = false.obs;
  RxString date = ''.obs;
  final PendingFilesController _pendingFilesController =
      Get.find<PendingFilesController>();
  var customerData = CustomerData(
    id: 0,
    name: '',
    phoneNumber: '',
    alternateNumber: '',
    location: '',
    tagsId: [],
    businessTypeTagsId: [],
    agentId: 0,
    userId: '',
    followUpDate: '',
    additionalNote: '',
    createdDate: '',
    isFinalCustomer: null,
  ).obs;
  ApiService _apiService = ApiService();
  Rx<FocusNode> focusNode = FocusNode().obs;

  @override
  void onInit() {
    isSaved.value = false;
    update();
    getTagListData();
    getBussinessTagListData();
    super.onInit();
  }

  void formatDate(String inputDate) {
    // Parse the input date string into a DateTime object
    DateTime parsedDate = DateTime.parse(inputDate);

    // Extract day, month, and year
    String day = parsedDate.day.toString().padLeft(2, '0');
    String month = parsedDate.month.toString().padLeft(2, '0');
    String year = parsedDate.year.toString();

    //Time formatting
    int hour = parsedDate.hour > 12 ? parsedDate.hour - 12 : parsedDate.hour;
    hour = hour == 0 ? 12 : hour; // Convert 0 hour to 12
    // String minute = parsedDate.minute.toString().padLeft(2, '0');
    // String second = parsedDate.second.toString().padLeft(2, '0');
    // String period = parsedDate.hour >= 12 ? "PM" : "AM";
    // String convertedtime =
    //     "${hour.toString().padLeft(2, '0')}:$minute:$second $period";
    date.value = "$year-$month-$day";
    update();
  }

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
          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
    }
  }

  // Function to save form data
  Future<void> saveCustomer(int id) async {
    isSaved.value = true;
    update();

    // Form submission logic (replace with API calls or database saving logic)
    if (cusFormKey.value.currentState!.validate()) {
      if (followUpDateController.text.isEmpty) {
        Get.snackbar('Error', 'Please select a follow-up date');
      } else if (locationController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter a location');
      } else if (selectbusinesstagList.isEmpty) {
        Get.snackbar('Error', 'Please select a business tag');
      } else if (selectagstagList.isEmpty) {
        Get.snackbar('Error', 'Please select a tag');
      } else if (nameController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter a name');
      } else {
        final request = CreateNewCustomer(
            id: id,
            name: nameController.text,
            phoneNumber: contactController.text,
            alternateNumber: altContactController.text,
            folowUpDate: followUpDateController.text,
            location: locationController.text,
            tagsId: selectedTagId,
            businessTypeTagsId: selectedBTagId,
            agentId: selectedATagId.value,
            userId: LocalStorageManager.getUserId(),
            additionalNote: remarksController.text);
        final data = jsonEncode(request.toApiFormat());
        print("DATA :$data");

        await _apiService.createNewCustomer(request, getToken());

        // Display success message
        Get.snackbar("Success", "Customer Added Successfully",
            backgroundColor: Colors.green, colorText: Colors.white);
        clearController();
        isSaved.value = false;
        update();
      }
    }

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

  Future<TagListResponse> getagentTagListData() async {
    final tags = await _apiService.fetchAgentTag(getToken());
    agenttagList.value = tags.data;
    update();
    return tags;
  }

  int getColor(String color) {
    if (color.contains('#')) {
      return int.parse(color.replaceFirst('#', '0xFF'));
    } else {
      return int.parse('0xFFFFFFFF');
    }
  }

  void onTagSelected(int tagId, String label) {
    if (label == 'Tags' && !selectedTagId.contains(tagId)) {
      selectedTagId.add(tagId.toString());
    } else if (label == 'Business Type' && !selectedBTagId.contains(tagId)) {
      selectedBTagId.add(tagId.toString());
    } else {
      selectedATagId.value = tagId;
    }
    update();
    print("Selected Tag ID: $tagId");
  }

  void onTagNameSelected(Tag tag, bool? isBussiness) {
    if (isBussiness == true) {
      selectbusinesstagList.add(tag);
      update();
    } else if (isBussiness == false) {
      selectagstagList.add(tag);
    } else {
      selectagenTtagList.add(tag);
      update();
    }
    print("Selected Tag name: $tag");
  }

  Future<dynamic> onEdit(String id) async {
    final data = await _apiService.getCustomerInfo(getToken(), id);
    customerData.value = data.data;
    fillData();
    Future.delayed(Durations.medium4);
    final result = await Get.toNamed(Routes.add_new_cus);
    if (result != null) {
      await _pendingFilesController.getApiData(1);
    }
    update();
  }

  void fillData() {
    if (customerData.value.id != 0) {
      final data = customerData.value;
      formatDate(data.followUpDate);
      nameController.text = data.name;
      contactController.text = data.phoneNumber;
      altContactController.text = data.alternateNumber;
      followUpDateController.text = date.value;
      remarksController.text = data.additionalNote;
      locationController.text = data.location;
      id.value = data.id;
    }
  }

  void clearController() {
    nameController.clear();
    contactController.clear();
    contactController.clear();
    altContactController.clear();
    bussinessController.value.clear();
    tagsController.value.clear();
    agentController.value.clear();
    followUpDateController.clear();
    remarksController.clear();
    locationController.clear();
    selectagstagList.clear();
    selectbusinesstagList.clear();
    selectagenTtagList.clear();
    id.value = 0;
    if (selectedTagId.isNotEmpty) {
      selectedTagId.clear();
    }
    if (selectedBTagId.isNotEmpty) {
      selectedBTagId.clear();
    }
    selectedATagId.value = 0;
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
    selectagstagList.clear();
    selectbusinesstagList.clear();
    super.onClose();
  }
}
