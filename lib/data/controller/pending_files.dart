import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/add_new_customer.dart';
import 'package:shiva_poly_pack/data/model/new_customer.dart';
import 'package:shiva_poly_pack/data/model/pending_files.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';
import 'package:shiva_poly_pack/routes/app_routes.dart';

class PendingFilesController extends GetxController {
  var pendingFilesList = <PendingFile>[].obs;
 
  ApiService _apiService = ApiService();
  RxString time = ''.obs;
  RxString date = ''.obs;
  RxString selectedOption = 'Z-A'.obs;
  // final AddCustomerController _customerController =
  //     Get.put(AddCustomerController());

  void sortLeads() {
    if (selectedOption.value == 'A-Z') {
// Sort A-Z
      pendingFilesList.sort((a, b) => a.location.compareTo(b.location));
    } else {
// Sort Z-A
      pendingFilesList.sort((a, b) => b.location.compareTo(a.location));
    }
    update();
    print('Leads List: ${pendingFilesList.first.location}');
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



  Future<PendingFilesResponse> getApiData() async {
    final files = await _apiService.fetchPendingFiles(getToken());
    pendingFilesList.value = files.pendingFiles as List<PendingFile>;
    update();
    return files;
  }

  void formatDate(String inputDate) {
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
  }
}
