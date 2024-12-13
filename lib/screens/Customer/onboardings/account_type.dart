import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/account_type.dart';
import 'package:shiva_poly_pack/material/buttons.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';

import '../../../material/account_card.dart';

class AccountSelection extends GetView<AccountTypeController> {
  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Scaffold(
      backgroundColor: ColorPallets.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.brown),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "Choose Login Type",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ColorPallets.themeColor,
              ),
            ),
          ),
          Text(
            "Select the type of account you want to log in with.",
            style: Styles.getstyle(
                fontweight: FontWeight.w500, fontsize: _ui.widthPercent(3.5)),
          ),
          const SizedBox(height: 20),
          // Customer Account Selection
          GestureDetector(
            onTap: () => controller.choosed_type(customerLogin: true),
            child: Obx(
              () => AccountCard(
                title: "Customer Login",
                description: "For customers looking to explore our services.",
                image: 'assets/images/onboardings/customer.png',
                isSelected: controller.isCustomer.value,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Staff Account Selection
          GestureDetector(
            onTap: () => controller.choosed_type(customerLogin: false),
            child: Obx(
              () => AccountCard(
                title: "Staff Login",
                description: "For staff members to manage and assist users.",
                image: 'assets/images/onboardings/staff.png',
                isSelected: controller.isStaff.value,
              ),
            ),
          ),
          SizedBox(
            height: _ui.widthPercent(8),
          ),
          // Continue Button
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
              child: InkWell(
                  onTap: () => controller.navigation(),
                  child: reuseable_button(ui: _ui, button_text: 'Continue'))),
        ],
      ),
    );
  }
}
