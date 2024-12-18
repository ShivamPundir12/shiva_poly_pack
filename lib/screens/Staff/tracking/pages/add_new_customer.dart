import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/add_new_customer.dart';
import 'package:shiva_poly_pack/data/model/tag_list.dart';
import 'package:shiva_poly_pack/data/services/validation.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';

import '../../../../material/styles.dart';

class AddCustomerScreen extends GetView<AddCustomerController> {
  AddCustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check keyboard visibility using viewInsets.bottom
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    ResponsiveUI _ui = ResponsiveUI(context);
    controller.getTagListData();
    controller.getBussinessTagListData();

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
            controller.clearController();
            Get.back(canPop: true);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: isKeyboardVisible
            ? EdgeInsets.symmetric(
                vertical: _ui.heightPercent(4),
                horizontal: _ui.widthPercent(3),
              )
            : const EdgeInsets.all(16.0),
        child: Container(
          height: isKeyboardVisible ? _ui.heightPercent(100) : null,
          child: Form(
            key: controller.cusFormKey.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextField(
                    'Name', 'John Doe', controller.nameController, true),
                buildRowFields(_ui.screenWidth),
                Obx(
                  () => buildTagSelectionField(
                    context: context,
                    ui: _ui,
                    selectedlist: controller.selectbusinesstagList,
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
                    context: context,
                    ui: _ui,
                    selectedlist: controller.selectagstagList,
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
                    context: context,
                    ui: _ui,
                    label: "Agent",
                    selectedlist: controller.selectagenTtagList,
                    isRequired: false,
                    isBusiness: true,
                    options: controller.agenttagList,
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
        ),
      ),
    );
  }

  // Text Field Widget
  Widget buildTextField(String label, String hint,
      TextEditingController controller, bool isReqquired) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
              if (isReqquired)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    '*',
                    style: Styles.getstyle(
                        fontweight: FontWeight.bold, fontcolor: Colors.red),
                  ),
                )
            ],
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            keyboardType: label == 'Contact' || label == 'Alternative No.'
                ? TextInputType.phone
                : TextInputType.name,
            maxLength:
                label == 'Contact' || label == 'Alternative No.' ? 10 : null,
            validator: (value) =>
                label == 'Contact' || label == 'Alternative No.'
                    ? ValidationService.validateMobileNumber(value)
                    : isReqquired
                        ? ValidationService.normalvalidation(value)
                        : null,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: Styles.getstyle(
                fontcolor: ColorPallets.fadegrey.withOpacity(0.6),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: ColorPallets.themeColor)),
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
            'Contact',
            'Enter contact',
            controller.contactController,
            true,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: buildTextField('Alternative No.', 'Enter alt no.',
                controller.altContactController, false),
          ),
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
    required ResponsiveUI ui,
    required bool isRequired,
    required RxList<Tag> selectedlist,
    required BuildContext context,
    required Function(int) onTagSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label and Required Asterisk
          Row(
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
              if (isRequired)
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '*',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),

          // TextFormField with selected Chip
          InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              _showTagSelectionBottomSheet(
                selectedTags: selectedlist.toList(),
                options: options,
                isBusiness: isBusiness,
                onTagSelected: onTagSelected,
              );
            },
            child: InputDecorator(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                hintText: 'Select $label',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
              ),
              child: Wrap(
                spacing: 8.0, // Horizontal spacing between chips
                runSpacing: 4.0, // Vertical spacing between rows
                children: [
                  if (selectedlist.isNotEmpty)
                    ...selectedlist.map((tag) => Chip(
                          label: Text(tag.name),
                          onDeleted: () {
                            // Handle chip deletion
                            selectedlist.remove(tag);
                            (context as Element).markNeedsBuild();
                          },
                        )),
                  if (selectedlist.isEmpty)
                    const Text(
                      'Select an option',
                      style: TextStyle(color: Colors.grey),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// BottomSheet for tag selection
  void _showTagSelectionBottomSheet({
    required List<Tag> options,
    required bool isBusiness,
    required Function(int) onTagSelected,
    required List<Tag> selectedTags,
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
                  bool hastag = selectedTags.any(
                    (element) => element.id == tag.id,
                  );
                  return ListTile(
                    tileColor: hastag ? ColorPallets.fadegrey : null,
                    selectedColor: hastag ? ColorPallets.fadegrey : null,
                    selectedTileColor: !hastag ? ColorPallets.fadegrey : null,
                    title: Text(
                      tag.name,
                      style: Styles.getstyle(
                          fontcolor: hastag ? ColorPallets.fadegrey : null),
                    ),
                    onTap: () {
                      if (!hastag) {
                        onTagSelected(tag.id);
                        // Pass selected tag ID
                        controller.onTagNameSelected(tag, tag.isBusinessTag);
                        Get.back(); // Close BottomSheet
                      } else {
                        Get.snackbar('Info', 'This tag is already used!',
                            colorText: ColorPallets.white);
                      }
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Follow up Date',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  '*',
                  style: Styles.getstyle(
                      fontweight: FontWeight.bold, fontcolor: Colors.red),
                ),
              )
            ],
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller.followUpDateController,
            readOnly: true,
            validator: ValidationService.normalvalidation,
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
