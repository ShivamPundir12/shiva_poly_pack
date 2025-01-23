import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shiva_poly_pack/data/model/pending_files.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';

import '../../material/indicator.dart';

class PendingFilesController extends GetxController {
  var pendingFilesList = <PendingFile>[].obs;
  var filterpendingFilesList = <PendingFile>[].obs;
  ScrollController scrollController = ScrollController();

  ApiService _apiService = ApiService();
  RxString time = ''.obs;
  RxString date = ''.obs;
  RxString selectedOption = 'Z-A'.obs;
  RxBool isloading = true.obs;
  RxBool isLastPage = false.obs;
  RxInt currentPage = 1.obs;
  final int pageSize = 10;
  RxInt total_pages = 0.obs;

  @override
  void onInit() {
    super.onInit();
    GetStorage.init();
  }

  Future<PendingFilesResponse> searchData(String searchValue) async {
    isloading.value = true;
    filterpendingFilesList.clear();
    final files = await _apiService.fetchPendingFiles(
        getToken(), currentPage.value,
        searchValue: searchValue);
    bool hasdata = filterpendingFilesList
        .any((e) => files.pendingFiles.any((v) => e.id != v.id));
    if (files.pendingFiles.isNotEmpty) {
      filterpendingFilesList.addAllIf(!hasdata, files.pendingFiles);
    } else {
      isLastPage.value = true;
    }
    Future.delayed(Duration(milliseconds: 1000), () {
      isloading.value = false;
    });
    update();
    return files;
  }

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

  Future<void> nextPage() async {
    LoadingView.show();
    await getApiData(currentPage.value + 1);
    LoadingView.hide();
    Future.delayed(Durations.medium3);
    scrollController.position.jumpTo(scrollController.position.maxScrollExtent);
    update();
  }

  Future<PendingFilesResponse> getApiData(int page) async {
    final files =
        await _apiService.fetchPendingFiles(getToken(), currentPage.value);
    bool hasdata = pendingFilesList
        .any((e) => files.pendingFiles.any((v) => e.id != v.id));
    if (files.pendingFiles.isNotEmpty) {
      if (page == 1) {
        pendingFilesList.assignAll(files.pendingFiles);
      } else {
        pendingFilesList.addAllIf(!hasdata, files.pendingFiles);
      }
      currentPage.value = page;
      isLastPage.value = currentPage >= files.pagination.totalPages;
      total_pages.value = files.pagination.totalPages;
    } else {
      isLastPage.value = true;
    }
    Future.delayed(Duration(milliseconds: 1500), () {
      isloading.value = false;
    });
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
