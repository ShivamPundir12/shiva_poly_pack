import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/model/follow_up.dart';
import 'package:shiva_poly_pack/data/model/tag_list.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';

class FollowUp extends GetxController {
  // Define sorting options
  RxString selectedOption = 'A-Z'.obs;
  ApiService _apiService = ApiService();
  RxBool loading = true.obs;
  RxString time = ''.obs;
  RxString date = ''.obs;

  final RxInt selectedTagId = 0.obs;
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

  DateTime convertToISO8601(String inputDate) {
    // Parse the input date assuming the format "dd-MM-yyyy"
    final inputFormat = RegExp(r'^(\d{2})-(\d{2})-(\d{4})$');
    final match = inputFormat.firstMatch(inputDate);

    if (match == null) {
      throw FormatException("Invalid date format. Expected 'dd-MM-yyyy'");
    }

    // Extract day, month, and year
    final day = int.parse(match.group(1)!);
    final month = int.parse(match.group(2)!);
    final year = int.parse(match.group(3)!);

    // Create a DateTime object with time at 17:29:47.741 (fixed time in UTC)
    final dateTime = DateTime.utc(year, month, day);

    // Return as an ISO 8601 string
    return dateTime;
  }

  // Function to save the form data
  Future<void> saveFollowUp(String selectedcrmID) async {
    print('Follow up Date: ${followUpDateController.text}');
    print('Review: ${reviewController.text}');
    print('Selected Tag: ${selectedTag.value}');

    if (followUpDateController.text.isEmpty) {
      Get.snackbar('Error', 'Please select a follow-up date');
    } else if (reviewController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a review');
    } else if (selectedTagId.value == 0) {
      Get.snackbar('Error', 'Please select a tag');
    } else {
      final request = CreateFollowupModel(
        crmId: selectedcrmID,
        followupDate: convertToISO8601(followUpDateController.text),
        review: reviewController.text,
        tags: selectedTagId.value.toString(),
      );
      await _apiService.createFollowUp(request, getToken()).then((v) async {
        if (v.data.id != 0) {
          await getApiData();
        }
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar("Success", "FollowUp Created Successfully",
            backgroundColor: Colors.green, colorText: Colors.white);
      });
      clearController();
    }
  }

  void sortLeads() {
    if (selectedOption.value == 'A-Z') {
// Sort A-Z
      followUpList.sort((a, b) => a.location.compareTo(b.location));
    } else {
// Sort Z-A
      followUpList.sort((a, b) => b.location.compareTo(a.location));
    }
    update();
    print('Leads List: ${followUpList.first.location}');
  }

  // Method to display bottom sheet
  Future<void> selectOption(BuildContext context) async {
    if (selectedOption.value == 'A-Z') {
      selectedOption.value = 'Z-A';
    } else {
      selectedOption.value = 'A-Z';
    }
    sortLeads();
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
          tagsName: e['tagsName'] ?? [],
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
      context: Navigator.of(context, rootNavigator: true)
          .context, // Use the root navigator's context
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      followUpDateController.text =
          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
    }
  }

  void clearController() {
    followUpDateController.clear();
    reviewController.clear();
    selectedTag.value = '';
    selectedTagId.value = 0;
    Get.back();
  }

  String formatDate(String inputDate) {
    // Parse the input date string into a DateTime object
    DateTime parsedDate = DateTime.parse(inputDate);

    // Extract day, month, and year
    String day = parsedDate.day.toString().padLeft(2, '0');
    String month = parsedDate.month.toString().padLeft(2, '0');
    String year = parsedDate.year.toString().substring(2);

    //Time formatting
    int hour = parsedDate.hour > 12 ? parsedDate.hour - 12 : parsedDate.hour;
    hour = hour == 0 ? 12 : hour; // Convert 0 hour to 12
    String minute = parsedDate.minute.toString().padLeft(2, '0');
    String second = parsedDate.second.toString().padLeft(2, '0');
    String period = parsedDate.hour >= 12 ? "PM" : "AM";
    String convertedtime =
        "${hour.toString().padLeft(2, '0')}:$minute:$second $period";
    time.value = convertedtime;
    date.value = "$day-$month-$year";
    update();
    return date.value;
  }

  // Cleanup controllers when the controller is disposed
  @override
  void onClose() {
    followUpDateController.dispose();
    reviewController.dispose();
    super.onClose();
  }
}
