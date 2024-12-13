import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/add_new_customer.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';

import '../../../../material/styles.dart';

class AddCustomerScreen extends GetView<AddCustomerController> {
  AddCustomerScreen(
      {Key? key,
      this.selectedBusinessType,
      this.selectedTag,
      this.selectedAgent})
      : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController altContactController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController followUpController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  final String? selectedBusinessType;
  final String? selectedTag;
  final String? selectedAgent;

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);

    return Scaffold(
      backgroundColor: ColorPallets.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorPallets.white,
        bottom: PreferredSize(
            preferredSize: Size(_ui.widthPercent(70), _ui.heightPercent(2)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: _ui.widthPercent(5)),
              child: Divider(
                color: Colors.grey.shade400,
                thickness: 2.3,
              ),
            )),
        centerTitle: true,
        title: Text(
          'Add New Customer',
          style: Styles.getstyle(
              fontweight: FontWeight.bold, fontsize: _ui.widthPercent(6)),
        ),
        leading: IconButton(
          padding: EdgeInsets.only(
            left: _ui.widthPercent(5),
          ),
          icon: Icon(
            Icons.arrow_back,
            color: ColorPallets.themeColor,
            size: _ui.widthPercent(7),
          ),
          onPressed: () {
            Get.back(canPop: true);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextField('Name', 'John Doe', controller.nameController),
            buildRowFields(_ui.screenWidth),
            buildDropdownField('Business Type', ['Retail', 'Wholesale'],
                controller.selectedBusinessType),
            buildDropdownField(
                'Tags', ['VIP', 'Regular'], controller.selectedTag),
            buildDropdownField(
                'Agent', ['Agent 1', 'Agent 2'], controller.selectedAgent),
            buildDatePickerField(context),
            buildRemarksField(),
            const SizedBox(height: 20),
            buildSaveButton(),
          ],
        ),
      ),
    );
  }

  // Text Field Widget
  Widget buildTextField(
      String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: Styles.getstyle(
                fontcolor: ColorPallets.fadegrey.withOpacity(0.6),
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Row Fields for Contact and Alternative No.
  Widget buildRowFields(double screenWidth) {
    return Row(
      children: [
        Expanded(
          child: buildTextField(
              'Contact', 'Enter contact', controller.contactController),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: buildTextField('Alternative No.', 'Enter alt no.',
              controller.altContactController),
        ),
      ],
    );
  }

  // Dropdown Field Widget
  Widget buildDropdownField(
      String label, List<String> options, RxnString selectedValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Obx(() => DropdownButtonFormField<String>(
                value: selectedValue.value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                hint: Text(
                  'Choose anything',
                  style: Styles.getstyle(
                      fontcolor: ColorPallets.fadegrey.withOpacity(0.6)),
                ),
                items: options
                    .map((option) =>
                        DropdownMenuItem(value: option, child: Text(option)))
                    .toList(),
                onChanged: (value) {
                  selectedValue.value = value;
                },
              )),
        ],
      ),
    );
  }

  // Date Picker Field
  Widget buildDatePickerField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Follow up Date',
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller.followUpDateController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'dd/mm/yyyy',
              hintStyle: Styles.getstyle(
                fontcolor: ColorPallets.fadegrey.withOpacity(0.6),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => controller.selectDate(context),
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Remarks Field
  Widget buildRemarksField() {
    return buildTextField(
        'Additional Note/Remarks', 'Say it', controller.remarksController);
  }

  // Save Button
  Widget buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: controller.saveCustomer,
        icon: const Icon(Icons.save),
        label: const Text('Save'),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorPallets.themeColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
