import 'package:get/get.dart';

class LoadingController extends GetxController {
  var isLoading = false.obs; // Observable loading state

  /// Simulate an API call or a long-running task
  Future<void> simulateTask() async {
    isLoading.value = true; // Show loading indicator
    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay
    isLoading.value = false; // Hide loading indicator
  }
}
