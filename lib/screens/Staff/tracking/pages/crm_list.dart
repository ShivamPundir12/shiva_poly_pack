import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/pages/material/list_card.dart';
import '../../../../data/controller/crm_list.dart';
import '../../../../material/color_pallets.dart';
import '../../../../material/styles.dart';

class CRMListScreen extends GetView<CRMListController> {
  CRMListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getCRMList();
    ResponsiveUI _ui = ResponsiveUI(context);
    return Scaffold(
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
          'List',
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
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     onChanged: (value) {
          //       controller.filterCustomerList(value, controller.customerList,
          //           controller.filteredCustomerList);
          //     },
          //     decoration: InputDecoration(
          //       labelText: 'Search',
          //       border: OutlineInputBorder(),
          //       suffixIcon: Icon(Icons.search),
          //     ),
          //   ),
          // ),
          Expanded(
            child: FutureBuilder<dynamic>(
                future: controller.getCRMList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else {
                    return Obx(
                      () {
                        if (controller.filteredCustomerList.isEmpty) {
                          return Container(
                            height: _ui.screenHeight / 1.9,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_off,
                                  size: _ui.heightPercent(14),
                                  color: ColorPallets.themeColor,
                                ),
                                Text(
                                  'No Data..',
                                  style: Styles.getstyle(
                                    fontweight: FontWeight.w600,
                                    fontsize: _ui.widthPercent(5),
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: controller.filteredCustomerList.length,
                            itemBuilder: (context, index) {
                              return CustomerCard(index: index);
                            },
                          );
                        }
                      },
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
