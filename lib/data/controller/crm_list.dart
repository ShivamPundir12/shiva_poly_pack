import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/follow_up.dart';
import 'package:shiva_poly_pack/data/model/crm_list.dart';
import 'package:shiva_poly_pack/data/model/follow_up.dart';
import 'package:shiva_poly_pack/data/model/tag_list.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';
import 'package:shiva_poly_pack/material/indicator.dart';

class CRMListController extends GetxController {
  // Sample CRM list data
  RxList<CRMListModel> customerList = <CRMListModel>[].obs;
  RxList<Tag> tagList = <Tag>[].obs;
  ApiService _apiService = ApiService();
  var postfollowUpList = <PostedFollowUp>[].obs;
  final FollowUp followUpController = Get.find<FollowUp>();
  RxString color = ''.obs;
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

  // Function to filter the customer list based on a condition
  void filterCustomerList(String query, List<CRMListModel> customerList,
      RxList<CRMListModel> filteredCustomerList) {
    if (query.isEmpty) {
      // If the query is empty, return all customers
      filteredCustomerList.assignAll(customerList);
    } else {
      // Perform filtering based on the query
      final lowercaseQuery = query.toLowerCase();
      final filteredList = customerList.where((customer) {
        // Ensure the customer's name is not null and check if it matches the query
        final name = customer.name.toLowerCase();
        return name.contains(lowercaseQuery);
      }).toList();

      // Update the filtered list
      filteredCustomerList.assignAll(filteredList);
    }
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
        await getCRMList();
      }
    });
  }

  Future<void> getCRMList() async {
    final crmList = await _apiService.fetchCRMListCustomer(getToken());
    customerList.value = crmList;
    update();
    filteredCustomerList.assignAll(customerList);
  }

  Future<TagListResponse> getTagListData() async {
    final tags = await _apiService.fetchTag(getToken());
    tagList.value = tags.data;
    update();
    return tags;
  }

  Future<void> fetchfollowUp(String id) async {
    await followUpController.getFollowUpData(id);
  }
}
