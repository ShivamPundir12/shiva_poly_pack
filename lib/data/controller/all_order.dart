import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/Customer/home/notification.dart';
import '../model/cus_pending_order.dart';
import '../services/api_service.dart';

class AllOrderController extends GetxController {
  ApiService _apiService = ApiService();
  RxBool isloading = true.obs;
  RxBool isLastPage = false.obs;
  RxInt currentPage = 1.obs;
  final int pageSize = 10;
  RxInt total_pages = 0.obs;
  RxString selectedOption = 'Z-A'.obs;
  String baseUrl = 'https://spolypack.com/OrderImages';

  var allOrderList = <PendingOrderData>[].obs;
  var filterallOrderList = <PendingOrderData>[].obs;

  void sortLeads() {
    if (selectedOption.value == 'A-Z') {
// Sort A-Z
      allOrderList.sort((a, b) => a.jobName!.compareTo(b.jobName ?? ''));
    } else {
// Sort Z-A
      allOrderList.sort((a, b) => b.jobName!.compareTo(a.jobName ?? ''));
    }
    update();
    print('Leads List: ${allOrderList.first.jobName}');
  }

  // Method to display bottom sheet
  Future<void> selectOption(BuildContext context) async {
    if (selectedOption.value == 'A-Z') {
      selectedOption.value = 'Z-A';
    } else {
      selectedOption.value = 'A-Z';
    }
    if (allOrderList.isNotEmpty) {
      sortLeads();
    }
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

  Future<PendingOrderResponse> getApiData(int page) async {
    final files = await _apiService.fetchAllOrder(
      getToken(),
      currentPage.value,
    );
    bool hasdata = allOrderList.any((e) => files.data.any((v) => e.id != v.id));
    if (files.data.isNotEmpty) {
      if (page == 1) {
        allOrderList.assignAll(files.data);
      } else {
        allOrderList.addAllIf(!hasdata, files.data);
      }
      currentPage.value = page;
      // isLastPage.value = currentPage >= files.pagination.totalPages;
      // total_pages.value = files.pagination.totalPages;
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
