import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/model/ledger.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';

import '../../material/indicator.dart';
import '../../screens/Customer/home/notification.dart';

class LedgerReportController extends GetxController {
  var expandedIndex = (-1).obs;
  ApiService _apiService = ApiService();
  RxInt currentPage = 1.obs;
  RxInt total_pages = 1.obs;
  var ledgerDatalist = <LedgerData>[].obs;
  var filterledgerDatalist = <LedgerData>[].obs;
  RxBool isLastPage = false.obs;
  RxString selectedOption = 'Z-A'.obs;
  RxBool isloading = false.obs;
  String baseUrl = 'https://spolypack.com';

  Future<void> prevPage() async {
    LoadingView.show();
    await getApiData(currentPage.value - 1);
    LoadingView.hide();
    update();
  }

  Future<void> nextPage() async {
    LoadingView.show();
    await getApiData(currentPage.value + 1);
    LoadingView.hide();
    update();
  }

  void showNotificationMenu() {
    Get.dialog(
      NotificationMenu(
        onDisable: () {
          print('Disable Notifications');
          Get.back(); // Close menu
        },
        onAllowAll: () {
          print('Allow All Notifications');
          Get.back(); // Close menu
        },
        onFestive: () {
          print('Only Festive Notifications');
          Get.back(); // Close menu
        },
      ),
      barrierColor: Colors.transparent, // Ensures a transparent background
      useSafeArea: true,
    );
  }

  Future<LedgerModel> searchData(String searchValue) async {
    isloading.value = true;
    filterledgerDatalist.clear();
    final files = await _apiService.fetchLedgerdata(
        getToken(), currentPage.value,
        searchValue: searchValue);
    bool hasdata =
        filterledgerDatalist.any((e) => files.data.any((v) => e.id == v.id));
    if (files.data.isNotEmpty) {
      filterledgerDatalist.addAllIf(!hasdata, files.data);
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
      ledgerDatalist.sort((a, b) => a.ledger!.compareTo(b.ledger ?? ''));
    } else {
// Sort Z-A
      ledgerDatalist.sort((a, b) => b.ledger!.compareTo(a.ledger ?? ''));
    }
    update();
    print('Leads List: ${ledgerDatalist.first.ledger}');
  }

  // Method to display bottom sheet
  Future<void> selectOption(BuildContext context) async {
    if (selectedOption.value == 'A-Z') {
      selectedOption.value = 'Z-A';
    } else {
      selectedOption.value = 'A-Z';
    }
    if (ledgerDatalist.isNotEmpty) {
      sortLeads();
    }
  }

  void toggleExpand(int index) {
    // If the same index is tapped, collapse it
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }

  Future<LedgerModel> getApiData(int page) async {
    final files = await _apiService.fetchLedgerdata(
      getToken(),
      currentPage.value,
    );
    bool hasdata =
        ledgerDatalist.any((e) => files.data.any((v) => e.id != v.id));
    if (files.data.isNotEmpty) {
      if (page == 1) {
        ledgerDatalist.assignAll(files.data);
      } else {
        ledgerDatalist.addAllIf(!hasdata, files.data);
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
}
