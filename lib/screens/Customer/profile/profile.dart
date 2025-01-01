import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';

import '../../../material/styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Scaffold(
      backgroundColor: ColorPallets.white2,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorPallets.white),
        backgroundColor: ColorPallets.themeColor,
        title: Text(
          'Profile',
          style: Styles.getstyle(
              fontcolor: ColorPallets.white,
              fontweight: FontWeight.bold,
              fontsize: _ui.widthPercent(6)),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_active,
              color: ColorPallets.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: ColorPallets.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      bottomSheet: Container(
        margin: EdgeInsets.symmetric(vertical: _ui.heightPercent(1.4)),
        child: // Save and Cancel Buttons
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                // Cancel logic
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: _ui.widthPercent(11)),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: ColorPallets.themeColor),
                    borderRadius: BorderRadius.circular(6)),
                backgroundColor: ColorPallets.white,
              ),
              child: Text(
                'Cancel',
                style: Styles.getstyle(
                    fontweight: FontWeight.w500,
                    fontcolor: ColorPallets.themeColor),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Save logic
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: _ui.widthPercent(11)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                backgroundColor: ColorPallets.themeColor,
              ),
              child: Text(
                'Save',
                style: Styles.getstyle(
                    fontweight: FontWeight.w500, fontcolor: ColorPallets.white),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture with Edit Icon
            Container(
              height: _ui.heightPercent(15),
              child: Stack(
                alignment: Alignment.bottomRight,
                fit: StackFit.passthrough,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: const NetworkImage(
                      'https://via.placeholder.com/150',
                    ),
                    backgroundColor: Colors.grey[300],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: _ui.widthPercent(19)),
                    child: IconButton(
                      style: IconButton.styleFrom(
                          shape: CircleBorder(),
                          backgroundColor: ColorPallets.white),
                      icon: Icon(Icons.edit_outlined,
                          color: ColorPallets.fadegrey),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Username Field
            _buildEditableField2(
              context: context,
              label: 'Username',
              value: 'example1234',
            ),
            const SizedBox(height: 10),

            // Mobile Number Field
            _buildEditableField2(
              context: context,
              label: 'Mobile no.',
              value: '+91 - 111 222 3333',
            ),
            const SizedBox(height: 10),

            // Name Field
            _buildEditableField(
              context: context,
              label: 'Name',
              showIcon: true,
              value: 'John Doe',
              onEdit: () {
                // Handle Name Edit
              },
            ),
            const SizedBox(height: 10),
            // Email Address Field
            _buildEditableField(
              context: context,
              showIcon: true,
              label: 'Email Address',
              value: 'example@gmail.com',
              onEdit: () {},
            ),
            const SizedBox(height: 10),
            // Shipping Address Field
            _buildEditableField(
              context: context,
              showIcon: true,
              label: 'Shipping Address',
              value: '13/ California, New York',
              onEdit: () {
                // Handle Shipping Address Edit
              },
            ),
            const SizedBox(height: 10),

            // Billing Address Field
            _buildEditableField(
              showIcon: true,
              context: context,
              label: 'Billing Address',
              value: '13/ California, New York',
              onEdit: () {
                // Handle Billing Address Edit
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(
      {required String label,
      required String value,
      required bool showIcon,
      required VoidCallback onEdit,
      required BuildContext context}) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Styles.getstyle(
                  fontweight: FontWeight.w600,
                  fontcolor: ColorPallets.fadegrey,
                  fontsize: _ui.widthPercent(4),
                ),
              ),
              const SizedBox(height: 4),
              Card(
                child: TextFormField(
                  controller: TextEditingController(text: value),
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: showIcon
                        ? IconButton(
                            icon: Icon(Icons.edit_outlined,
                                color: ColorPallets.themeColor),
                            onPressed: onEdit,
                          )
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEditableField2(
      {required String label,
      required String value,
      required BuildContext context}) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Styles.getstyle(
                  fontweight: FontWeight.w600,
                  fontcolor: ColorPallets.fadegrey,
                  fontsize: _ui.widthPercent(4),
                ),
              ),
              const SizedBox(height: 4),
              TextFormField(
                controller: TextEditingController(text: value),
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
