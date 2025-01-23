import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/follow_up.dart';
import 'package:shiva_poly_pack/data/model/crm_list.dart';
import 'package:shiva_poly_pack/data/model/follow_up.dart';
import 'package:shiva_poly_pack/data/model/tag_list.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/material/responsive.dart';

class CRMListController extends GetxController {
  // Sample CRM list data
  RxList<CRMListModel> customerList = <CRMListModel>[].obs;
  RxList<Tag> tagList = <Tag>[].obs;
  ApiService _apiService = ApiService();
  var postfollowUpList = <PostedFollowUp>[].obs;
  final FollowUp followUpController = Get.find<FollowUp>();
  RxString color = ''.obs;
  RxInt total_pages = 0.obs;
  final Rx<Tag> selectedTag = Tag(
    id: 0,
    name: '',
    color: '',
    isBusinessTag: false,
    createdDate: '',
    fontColor: '',
  ).obs;
  final RxList<String> selectedTagListId = <String>[].obs;
  RxList<CRMListModel> filteredCustomerList = <CRMListModel>[].obs;
  RxBool isLastPage = false.obs;
  RxBool isloading = false.obs;
  RxInt currentPage = 1.obs;
  final int pageSize = 10; // You can adjust this based on your API's page size
  ScrollController scrollController = ScrollController();

  // Function to filter the customer list based on a condition
  Future<void> filterCustomerList(String query) async {
    isloading.value = true;
    filteredCustomerList.clear();
    final crmList = await _apiService.fetchCRMListCustomer(
        getToken(), currentPage.value,
        searchValue: query);
    bool hasdata =
        filteredCustomerList.any((e) => crmList.data.any((v) => v.id == e.id));
    if (query.isNotEmpty) {
      filteredCustomerList.addAllIf(!hasdata, crmList.data);
    } else {
      filteredCustomerList.clear();
      getCRMList(1);
    }
    isloading.value = false;
  }

  void onTagSelected(int tagId, String label) {
    if (label == 'Tags' && !selectedTagListId.contains(tagId)) {
      selectedTagListId.add(tagId.toString());
    }
    update();
    print("Selected Tag ID: $tagId");
  }

  void onTagNameSelected(Tag tag) {
    selectedTag.value = tag;
    update();
  }

  void getcolor() {
    color.value = selectedTag.value.color.replaceFirst('#', '0xFF');
    update();
  }

  Future<dynamic> updateTag(String tagId, String id) async {
    await _apiService.updateTag(getToken(), tagId, id).then((v) async {
      if (v == 'Tag updated successfully!') {
        await getCRMList(currentPage.value);
      }
    });
  }

  Future<void> nextPage(BuildContext context) async {
    LoadingView.show();
    await getCRMList(currentPage.value + 1);
    LoadingView.hide();
    update();
  }

  Future<void> prevPage(BuildContext context) async {
    LoadingView.show();
    await getCRMList(currentPage.value - 1);
    LoadingView.hide();
    update();
  }

  Future<void> getCRMList(int page) async {
    final crmList = await _apiService.fetchCRMListCustomer(getToken(), page);
    bool hasdata =
        customerList.any((e) => crmList.data.any((v) => e.id != v.id));
    if (crmList.data.isNotEmpty) {
      if (page == 1) {
        customerList.value = crmList.data;
      } else {
        // customerList.addAllIf(hasdata, crmList.data);
        customerList.value = crmList.data;
        update();
      }
      currentPage.value = page;
      isLastPage.value = currentPage >= crmList.pagination.totalPages;
      total_pages.value = crmList.pagination.totalPages;
      update();
    } else {
      isLastPage.value = true;
    }
    update();
  }

  Future<TagListResponse> getTagListData() async {
    final tags = await _apiService.fetchTag(getToken());
    tagList.value = tags.data;
    update();
    return tags;
  }

  Future<void> fetchfollowUp(String id, int page) async {
    await followUpController.getFollowUpData(id: id, page: page);
  }
}
