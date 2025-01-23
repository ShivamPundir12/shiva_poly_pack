import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/pages/material/list_card.dart';
import '../../../../data/controller/crm_list.dart';
import '../../../../material/color_pallets.dart';
import '../../../../material/styles.dart';

class CRMListScreen extends GetView<CRMListController> {
  CRMListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            controller.currentPage.value = 1;
            if (controller.filteredCustomerList.isNotEmpty) {
              controller.filteredCustomerList.clear();
            }
            Get.back(canPop: true);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                controller.filterCustomerList(value);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Obx(() {
            return controller.filteredCustomerList.isNotEmpty
                ? Expanded(
                    child: Obx(
                      () {
                        if (controller.isloading.value) {
                          return Center(child: ProgressIndicatorWidget());
                        } else if (controller.filteredCustomerList.isEmpty) {
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
                          return Obx(
                            () => ListView.builder(
                              controller: controller.scrollController,
                              itemCount: controller.filteredCustomerList.length,
                              itemBuilder: (context, index) {
                                final customer =
                                    controller.filteredCustomerList[index];
                                return CustomerCard(
                                  index: index,
                                  customer: customer,
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                  )
                : Expanded(
                    child: FutureBuilder<dynamic>(
                        future:
                            controller.getCRMList(controller.currentPage.value),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          } else {
                            return Obx(
                              () {
                                if (controller.customerList.isEmpty) {
                                  return Container(
                                    height: _ui.screenHeight / 1.9,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                  return Obx(
                                    () => ListView.builder(
                                      controller: controller.scrollController,
                                      itemCount: controller.customerList.length,
                                      itemBuilder: (context, index) {
                                        final customer =
                                            controller.customerList[index];
                                        return CustomerCard(
                                          index: index,
                                          customer: customer,
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                            );
                          }
                        }),
                  );
          }),
          if (controller.filteredCustomerList.isEmpty)
            Obx(() {
              if (controller.customerList.isNotEmpty &&
                  controller.total_pages.value > 1) {
                // Pagination controls
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: () {
                        if (controller.currentPage.value > 1) {
                          controller.prevPage(context);
                        }
                      },
                    ),
                    Obx(() => Text(controller.currentPage.value.toString() +
                        " of " +
                        controller.total_pages.value.toString())),
                    IconButton(
                      icon: Icon(Icons.chevron_right),
                      onPressed: () {
                        print('Length : ${controller.customerList.length}');
                        if (!controller.isLastPage.value) {
                          controller.nextPage(context);
                        }
                      },
                    ),
                  ],
                );
              } else {
                return SizedBox.shrink();
              }
            }),
        ],
      ),
    );
  }
}
