import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:shiva_poly_pack/data/model/follow_up.dart';
import 'package:shiva_poly_pack/data/model/tag_list.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';

import '../../material/indicator.dart';

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
  var filterpostfollowUpList = <FollowupModel>[].obs;
  var tagList = <Tag>[].obs;
  RxInt post_followUp_total_pages = 0.obs;
  RxInt post_followUp_current_page = 0.obs;

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

  RxBool isLastPage = false.obs;
  RxBool isloading = false.obs;
  RxInt currentPage = 1.obs;
  RxInt total_pages = 0.obs;
  final int pageSize = 10; // You can adjust this based on your API's page size

  @override
  void onInit() {
    super.onInit();
  }

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
          await getApiData(currentPage.value);
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

  Future<void> nextPage(bool followUp) async {
    if (followUp) {
      LoadingView.show();
      await getApiData(currentPage.value + 1);
      LoadingView.hide();
      update();
    } else {
      LoadingView.show();
      await getFollowUpData(page: post_followUp_current_page.value + 1);
      LoadingView.hide();
      update();
    }
  }

  Future<void> prevPage(bool followUp) async {
    if (followUp) {
      LoadingView.show();
      await getApiData(currentPage.value - 1);
      LoadingView.hide();
      update();
    } else {
      LoadingView.show();
      await getFollowUpData(page: post_followUp_current_page.value - 1);
      LoadingView.hide();
      update();
    }
  }

  Future<FollowUpResponse> getApiData(int page) async {
    final followUp = await _apiService.fetchFollowUp(getToken(), page);
    if (followUp.followUp.isNotEmpty) {
      if (page == 1) {
        followUpList.assignAll(followUp.followUp);
      } else {
        // followUpList.addAllIf(
        //     !hasdata, followUp.followUp as List<FollowupModel>);
        followUpList.value = followUp.followUp;
      }
      currentPage.value = page;
      isLastPage.value = currentPage >= followUp.pagination.totalPages;
    } else {
      isLastPage.value = true;
    }
    update();
    return followUp;
  }

  Future<FollowUpResponse> searchData(String searchValue) async {
    isloading.value = true;
    filterpostfollowUpList.clear();
    final files = await _apiService.fetchFollowUp(getToken(), currentPage.value,
        searchValue: searchValue);
    bool hasdata = filterpostfollowUpList
        .any((e) => files.followUp.any((v) => e.id != v.id));
    if (files.followUp.isNotEmpty) {
      filterpostfollowUpList.addAllIf(!hasdata, files.followUp);
    } else {
      isLastPage.value = true;
    }
    Future.delayed(Duration(milliseconds: 1000), () {
      isloading.value = false;
    });
    update();
    return files;
  }

  Future<void> getFollowUpData({String? id, int? page}) async {
    final followUp = await _apiService.fetchPostedFollowUp(
        getToken(), id.toString(), page ?? 1);
    if (followUp.pendingFiles.isNotEmpty) {
      postfollowUpList.value = followUp.pendingFiles;
      currentPage.value = followUp.pagination.currentPage;
      post_followUp_total_pages.value = followUp.pagination.totalPages;
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
