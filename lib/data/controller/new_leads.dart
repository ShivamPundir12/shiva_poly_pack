import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/data/model/new_leads.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';
import 'package:shiva_poly_pack/material/indicator.dart';

class NewLeadsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  ApiService _apiService = ApiService();
  var largeleadsList = <Lead>[].obs;
  var smallleadsList = <Lead>[].obs;
  Rx<LeadsResponse> leadsResponse = Rx<LeadsResponse>(LeadsResponse(
      message: '', leadsWithLargeCustomer: [], leadsWithSmallCustomer: []));
  RxString selectedOption = 'Z-A'.obs;
  RxMap<int, bool> expandedStates = <int, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize TabController with two tabs
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void sortLeads() {
    if (selectedOption.value == 'A-Z') {
// Sort A-Z
      if (tabController.index == 0) {
        largeleadsList.sort((a, b) => a.location.compareTo(b.location));
      } else {
        smallleadsList.sort((a, b) => a.location.compareTo(b.location));
      }
    } else {
// Sort Z-A

      if (tabController.index == 0) {
        largeleadsList.sort((a, b) => b.location.compareTo(a.location));
      } else {
        smallleadsList.sort((a, b) => b.location.compareTo(a.location));
      }
    }
    update();
    print('Leads List: ${largeleadsList.first.location}');
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

  // Toggle expansion state for a particular index
  void toggle(int index) {
    expandedStates[index] = !(expandedStates[index] ?? false);
  }

  // Check if the card is expanded
  bool isExpanded(int index) => expandedStates[index] ?? false;

  Future<LeadsResponse> getApiData() async {
    final leads = await _apiService.fetchNewLeads(getToken());
    largeleadsList.value = leads.leadsWithLargeCustomer;
    smallleadsList.value = leads.leadsWithSmallCustomer;
    update();
    return leads;
  }

  // Future<void> setResponse() async {
  //   leadsResponse.value = await getApiData();
  //   update();
  // }
}
