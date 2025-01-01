import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shiva_poly_pack/data/controller/ledgercontroller.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';

class LedgerReportScreen extends GetView<LedgerReportController> {
  final List<Map<String, String>> ledgerData = [
    {"no": "10001", "name": "Sai Diksha Haldi Powder", "date": "12/27"},
    {"no": "10002", "name": "Sai Haldi Powder", "date": "12/25"},
    {"no": "10003", "name": "Diksha Haldi Powder", "date": "10/17"},
    {"no": "10004", "name": "Sai Haldi Powder", "date": "10/12"},
  ];

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text("Ledger Report"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search and Sort Section
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: "Orders",
                  items: const [
                    DropdownMenuItem(
                      value: "Orders",
                      child: Text("Orders"),
                    ),
                    DropdownMenuItem(
                      value: "Date",
                      child: Text("Date"),
                    ),
                  ],
                  onChanged: (value) {
                    // Handle sorting logic
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'No.',
                      style: Styles.getstyle(
                        fontweight: FontWeight.w500,
                        fontsize: _ui.widthPercent(4),
                        fontcolor: ColorPallets.themeColor,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Order Name',
                      style: Styles.getstyle(
                        fontweight: FontWeight.w500,
                        fontsize: _ui.widthPercent(4),
                        fontcolor: ColorPallets.themeColor,
                      ),
                    ),
                  ),
                  Container(
                    width: _ui.widthPercent(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Date',
                      style: Styles.getstyle(
                        fontweight: FontWeight.w500,
                        fontsize: _ui.widthPercent(4),
                        fontcolor: ColorPallets.themeColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: ColorPallets.themeColor,
            ),
            // Ledger Report List
            Expanded(
              child: ListView.separated(
                itemCount: ledgerData.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = ledgerData[index];

                  return Obx(() {
                    final isExpanded = controller.expandedIndex.value == index;

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () => controller.toggleExpand(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            color: isExpanded ? Colors.grey[100] : Colors.white,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item['no']!,
                                    style: Styles.getstyle(
                                        fontsize: _ui.widthPercent(3),
                                        fontweight: FontWeight.w500),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    item['name']!,
                                    style: Styles.getstyle(
                                        fontsize: _ui.widthPercent(3),
                                        fontweight: FontWeight.w700),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    item['date']!,
                                    textAlign: TextAlign.right,
                                    style: Styles.getstyle(
                                        fontsize: _ui.widthPercent(3),
                                        fontweight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  width: _ui.widthPercent(4),
                                ),
                                isExpanded
                                    ? Transform.rotate(
                                        angle: pi / 2,
                                        child: SvgPicture.asset(
                                          'assets/icons/list.svg',
                                          height: _ui.heightPercent(1.6),
                                          width: _ui.widthPercent(1.6),
                                        ),
                                      )
                                    : SvgPicture.asset(
                                        'assets/icons/list.svg',
                                        height: _ui.heightPercent(1.6),
                                        width: _ui.widthPercent(1.6),
                                      ),
                              ],
                            ),
                          ),
                        ),
                        // Expanded content
                        if (isExpanded)
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.grey[100],
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Request Invoice Logic
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                    ),
                                    child: const Text(
                                      "Request for the Invoice",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
