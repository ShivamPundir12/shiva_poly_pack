import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/add_new_customer.dart';
import 'package:shiva_poly_pack/data/model/tag_list.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';

import '../../../../material/styles.dart';

class AddCustomerScreen extends GetView<AddCustomerController> {
  AddCustomerScreen({Key? key}) : super(key: key);

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
            buildTextField('Name', 'John Doe', controller.nameController, true),
            buildRowFields(_ui.screenWidth),
            Obx(
              () => buildTagSelectionField(
                controller: controller.bussinessController,
                label: "Business Type",
                isRequired: true,
                isBusiness: true,
                options: controller.businesstagList,
                selectedTagId: controller.selectedBTagId.value,
                onTagSelected: (int id) {
                  controller.onTagSelected(id, true);
                },
              ),
            ),
            Obx(
              () => buildTagSelectionField(
                controller: controller.tagsController,
                label: "Tags",
                isRequired: true,
                isBusiness: true,
                options: controller.tagList,
                selectedTagId: controller.selectedTagId.value,
                onTagSelected: (int id) {
                  controller.onTagSelected(id, true);
                },
              ),
            ),
            Obx(
              () => buildTagSelectionField(
                label: "Agent",
                controller: controller.agentController,
                isRequired: false,
                isBusiness: true,
                options: controller.tagList,
                selectedTagId: controller.selectedATagId.value,
                onTagSelected: (int id) {
                  controller.onTagSelected(id, true);
                },
              ),
            ),
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
  Widget buildTextField(String label, String hint,
      TextEditingController controller, bool isReqquired) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.topRight,
        children: [
          Column(
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
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ],
          ),
          if (isReqquired)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                '*',
                style: Styles.getstyle(
                    fontweight: FontWeight.bold, fontcolor: Colors.red),
              ),
            )
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
              'Contact', 'Enter contact', controller.contactController, true),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: buildTextField('Alternative No.', 'Enter alt no.',
              controller.altContactController, false),
        ),
      ],
    );
  }

  // Dropdown Field Widget
  Widget buildTagSelectionField({
    required String label,
    required bool isBusiness,
    required List<Tag> options,
    required int selectedTagId,
    required bool isRequired,
    required TextEditingController controller,
    required Function(int) onTagSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.topRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              TextFormField(
                readOnly: true,
                onTap: () {
                  _showTagSelectionBottomSheet(
                    options: options,
                    isBusiness: isBusiness,
                    onTagSelected: onTagSelected,
                  );
                },
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Select $label',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                ),
              ),
            ],
          ),
          if (isRequired)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                '*',
                style: Styles.getstyle(
                    fontweight: FontWeight.bold, fontcolor: Colors.red),
              ),
            )
        ],
      ),
    );
  }

// BottomSheet for tag selection
  void _showTagSelectionBottomSheet({
    required List<Tag> options,
    required bool isBusiness,
    required Function(int) onTagSelected,
  }) {
    Get.bottomSheet(
      Container(
        height: 300,
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a tag',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final tag = options[index];
                  return ListTile(
                    title: Text(tag.name),
                    onTap: () {
                      onTagSelected(tag.id); // Pass selected tag ID
                      controller.onTagNameSelected(tag.name, tag.isBusinessTag);
                      Get.back(); // Close BottomSheet
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  // Date Picker Field
  Widget buildDatePickerField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.topRight,
        children: [
          Column(
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
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              '*',
              style: Styles.getstyle(
                  fontweight: FontWeight.bold, fontcolor: Colors.red),
            ),
          )
        ],
      ),
    );
  }

  // Remarks Field
  Widget buildRemarksField() {
    return buildTextField('Additional Note/Remarks', 'Say it',
        controller.remarksController, false);
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
