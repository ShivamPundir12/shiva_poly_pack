import 'package:get/get.dart';

class LedgerReportController extends GetxController {
  // Track which card is expanded
  var expandedIndex = (-1).obs;

  void toggleExpand(int index) {
    // If the same index is tapped, collapse it
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }
}
