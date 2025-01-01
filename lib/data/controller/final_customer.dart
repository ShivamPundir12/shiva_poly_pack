import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/model/final_customer.dart';
import 'package:shiva_poly_pack/data/model/tag_list.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';

import '../model/follow_up.dart';

class FinalCustomerController extends GetxController {
  RxList<FinalCustomerData> customerList = <FinalCustomerData>[].obs;
  ApiService _apiService = ApiService();
  RxString selectedOption = 'Z-A'.obs;
  RxString time = ''.obs;
  RxString date = ''.obs;
  final TextEditingController followUpDateController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
  final RxString selectedTag = ''.obs;
  final RxInt selectedTagId = 0.obs;
  var tagList = <Tag>[].obs;

  Future<void> saveFollowUp(String selectedcrmID) async {
    print('Follow up Date: ${followUpDateController.text}');
    print('Review: ${reviewController.text}');
    print('Selected Tag: ${selectedTag.value}');

    final request = CreateFollowupModel(
      crmId: selectedcrmID,
      followupDate: convertToISO8601(followUpDateController.text),
      review: reviewController.text,
      tags: selectedTagId.value.toString(),
    );
    await _apiService.createFollowUp(request, getToken()).then((v) async {
      if (v.data.id != 0) {
        Get.snackbar("Success", "FollowUp Created Successfully",
            backgroundColor: Colors.green, colorText: Colors.white);
        await getFollowUpData();
      } else {
        Get.snackbar('Error', 'Failed to add follow up',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    });
    clearController();
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

  void sortLeads() {
    if (selectedOption.value == 'A-Z') {
// Sort A-Z
      customerList.sort((a, b) => a.location.compareTo(b.location));
    } else {
// Sort Z-A
      customerList.sort((a, b) => b.location.compareTo(a.location));
    }
    update();
    print('Leads List: ${customerList.first.location}');
  }

  Future<FinalCustomerModel> getFollowUpData() async {
    final finalcustomerList = await _apiService.fetchFinalCustomer(getToken());
    customerList.value = finalcustomerList.data;
    update();
    return finalcustomerList;
  }

  Future<void> selectOption(BuildContext context) async {
    if (selectedOption.value == 'A-Z') {
      selectedOption.value = 'Z-A';
    } else {
      selectedOption.value = 'A-Z';
    }
    sortLeads();
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
          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
    }
  }

  Future<TagListResponse> getTagListData() async {
    final tags = await _apiService.fetchTag(getToken());
    tagList.value = tags.data;
    update();
    return tags;
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

  void clearController() {
    followUpDateController.clear();
    reviewController.clear();
    selectedTag.value = '';
    selectedTagId.value = 0;
    Get.back();
  }
}
