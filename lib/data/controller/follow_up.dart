import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/model/follow_up.dart';
import 'package:shiva_poly_pack/data/model/tag_list.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';

class FollowUp extends GetxController {
  // Define sorting options
  RxString selectedOption = 'Z-A'.obs;
  ApiService _apiService = ApiService();
  final RxInt selectedTagId = 0.obs;
  final RxInt selectedcrmID = 0.obs;
  var followUpList = <FollowupModel>[].obs;
  var postfollowUpList = <PostedFollowUp>[].obs;
  var tagList = <Tag>[].obs;

  final TextEditingController followUpDateController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();

  // Dropdown values
  final RxString selectedTag = ''.obs; // Observable to track the selected tag

  // List of tags for dropdown
  final List<String> tags = [
    'Negative',
    'In Process',
    'DESIGN APPROVED',
    'DESIGN IN PROCESS',
    'ORDER CONFIRMED',
  ];

  // Function to save the form data
  Future<void> saveFollowUp() async {
    print('Follow up Date: ${followUpDateController.text}');
    print('Review: ${reviewController.text}');
    print('Selected Tag: ${selectedTag.value}');

    final request = CreateFollowupModel(
      crmId: selectedcrmID.string,
      followupDate: DateTime.parse(followUpDateController.text),
      review: reviewController.text,
      tags: selectedTagId.value.toString(),
    );
    await _apiService.createFollowUp(request);
    clearController();
  }

  // Method to display bottom sheet
  Future<void> selectOption(BuildContext context) async {
    if (selectedOption.value == 'A-Z') {
      selectedOption.value = 'Z-A';
      update();
    } else {
      selectedOption.value = 'A-Z';
      update();
    }
  }

  Future<FollowUpResponse> getApiData() async {
    final followUp = await _apiService.fetchFollowUp(getToken());
    followUpList.value = followUp.followUp as List<FollowupModel>;
    update();
    return followUp;
  }

  Future<void> getFollowUpData(String id) async {
    final followUp = await _apiService.fetchPostedFollowUp(getToken(), id);
    // Ensure the response is a List
    if (followUp.isNotEmpty) {
      postfollowUpList.value = followUp.map((e) {
        return PostedFollowUp(
          customerName: e['customerName'] ?? '',
          followupDate: DateTime.parse(e['followupDate']),
          review: e['review'] ?? '',
          tags: PostedFollowUp.parseTags(e['tags']),
        );
      }).toList();
    }
    update();
  }

  Future<TagListResponse> getTagListData() async {
    final tags = await _apiService.fetchTag(getToken());
    tagList.value = tags.data;
    update();
    return tags;
  }

  void onTagSelected(int tagId) {
    selectedTagId.value = tagId;
    print("Selected Tag ID: $tagId");
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
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  Future<void> postFollowUp(CreateFollowupModel request) async {}

  void clearController() {
    followUpDateController.clear();
    reviewController.clear();
    selectedTag.value = '';
    selectedTagId.value = 0;
    Get.back();
  }

  // Cleanup controllers when the controller is disposed
  @override
  void onClose() {
    followUpDateController.dispose();
    reviewController.dispose();
    super.onClose();
  }
}
