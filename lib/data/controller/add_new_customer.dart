import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddCustomerController extends GetxController {
  // Text Editing Controllers for form fields
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final altContactController = TextEditingController();
  final locationController = TextEditingController();
  final followUpDateController = TextEditingController();
  final remarksController = TextEditingController();

  // Observables for dropdown fields
  var selectedBusinessType = RxnString(); // Nullable String
  var selectedTag = RxnString();
  var selectedAgent = RxnString();

  // Date Picker Logic
  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      followUpDateController.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  // Function to save form data
  void saveCustomer() {
    // Form submission logic (replace with API calls or database saving logic)
    if (nameController.text.isEmpty ||
        contactController.text.isEmpty ||
        selectedBusinessType.value == null) {
      Get.snackbar("Error", "Please fill all required fields",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Display success message
    Get.snackbar("Success", "Customer Saved Successfully",
        backgroundColor: Colors.green, colorText: Colors.white);

    // Debugging form values
    print("Name: ${nameController.text}");
    print("Contact: ${contactController.text}");
    print("Business Type: ${selectedBusinessType.value}");
    print("Tag: ${selectedTag.value}");
    print("Agent: ${selectedAgent.value}");
    print("Follow-up Date: ${followUpDateController.text}");
    print("Remarks: ${remarksController.text}");
  }

  @override
  void onClose() {
    // Dispose of controllers when the Controller is closed
    nameController.dispose();
    contactController.dispose();
    altContactController.dispose();
    locationController.dispose();
    followUpDateController.dispose();
    remarksController.dispose();
    super.onClose();
  }
}
