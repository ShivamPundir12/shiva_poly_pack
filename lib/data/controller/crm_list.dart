import 'package:get/get.dart';

class CRMListController extends GetxController {
  // Sample CRM list data
  RxList<Map<String, Object>> customerList = [
    {
      'name': 'ABC',
      'phoneNumber': '4343434343',
      'tags': ['Tag 2'],
      'location': 'mohali',
      'businessTag': 'Tag 1',
      'lastComment': 'adc',
      'partyName': 'aman',
    },
    {
      'name': 'Nikhil',
      'phoneNumber': '2342434',
      'tags': ['Tag 2'],
      'location': 'mohalli',
      'businessTag': 'Tag 1',
      'lastComment': '',
      'partyName': 'admin@gmail.com',
    },
    {
      'name': 'Nikhil',
      'phoneNumber': '1234567890',
      'tags': ['Tag 2'],
      'location': 'mohalli',
      'businessTag': 'Tag 1',
      'lastComment': 'Hello',
      'partyName': 'admin@gmail.com',
    },
  ].obs;

  void addTag(int index, String newTag) {
    // Safely cast 'tags' to List and add the new tag
    if (customerList[index]['tags'] is List) {
      (customerList[index]['tags'] as List).add(newTag);
      customerList.refresh();
    } else {
      // If 'tags' is null or not a List, initialize it as a List
      customerList[index]['tags'] = [newTag];
      customerList.refresh();
    }
  }
}
