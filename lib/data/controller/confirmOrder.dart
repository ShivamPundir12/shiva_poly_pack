import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/model/cus_pending_order.dart';
import 'package:shiva_poly_pack/data/services/api_service.dart';

class ConfirmorderController extends GetxController {
  ApiService _apiService = ApiService();
  RxBool isloading = true.obs;
  RxBool isLastPage = false.obs;
  RxInt currentPage = 1.obs;
  final int pageSize = 10;
  RxInt total_pages = 0.obs;
  RxDouble cylinderValue = 0.0.obs;
  RxString time = ''.obs;
  RxString date = ''.obs;
  String baseUrl = 'https://spolypack.com/OrderImages';

  var pendingOrderList = <PendingOrderData>[].obs;
  var filterpendingOrderList = <PendingOrderData>[].obs;

  Future<void> sliderProgress(double value) async {
    if (!value.isNegative) {
      cylinderValue.value = value;
      update();
    }
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

  Future<PendingOrderResponse> getApiData(int page) async {
    final files = await _apiService.fetchPendingOrders(
      getToken(),
      currentPage.value,
    );
    bool hasdata =
        pendingOrderList.any((e) => files.data.any((v) => e.id != v.id));
    if (files.data.isNotEmpty) {
      if (page == 1) {
        pendingOrderList.assignAll(files.data);
      } else {
        pendingOrderList.addAllIf(!hasdata, files.data);
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
