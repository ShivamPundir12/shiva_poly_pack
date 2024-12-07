import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/follow_up.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';

import '../../../../data/model/follow_up.dart';

class FollowUpScreen extends GetView<FollowUp> {
  final List<FollowUpItem> items = [
    FollowUpItem(
      location: 'Malerkotla',
      name: 'Daniel Food Products',
      phoneNumber: '9877566693',
      date: '12-02-2024',
    ),
    FollowUpItem(
      location: 'Adisoy',
      name: 'Ahmedgarh, Mandi',
      phoneNumber: '8532009697',
      date: '11-26-2024',
    ),
    FollowUpItem(
      location: 'Goa',
      name: 'Shiva Food Service',
      phoneNumber: '9458784339',
      date: '30-11-2024',
    ),
    FollowUpItem(
      location: 'Banglore',
      name: 'Laxmi Crockry Service',
      phoneNumber: '9058377960',
      date: '31-03-2024',
    ),
    // ... other items
  ];
  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Scaffold(
      backgroundColor: ColorPallets.white,
      extendBody: false,
      extendBodyBehindAppBar: false,
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
          'Follow Ups',
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(left: _ui.widthPercent(2)),
                  alignment: Alignment.centerLeft,
                  width: _ui.widthPercent(40),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      fillColor: ColorPallets.themeColor,
                      focusColor: ColorPallets.themeColor,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sort by',
                      style: Styles.getstyle(
                          fontweight: FontWeight.w700,
                          fontsize: _ui.widthPercent(3.5),
                          fontcolor: ColorPallets.fadegrey),
                    ),
                    SizedBox(
                      width: _ui.widthPercent(2),
                    ),
                    Stack(
                      fit: StackFit.loose,
                      alignment: Alignment.center,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(14),
                          radius: _ui.widthPercent(1),
                          onTap: () => controller.selectOption(context),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.grey.shade400, width: 0.1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            color: ColorPallets.white,
                            child: Container(
                              width: _ui.widthPercent(30),
                              height: _ui.heightPercent(5),
                              decoration: ShapeDecoration(
                                color: ColorPallets.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: ColorPallets.fadegrey, width: 0.4),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Obx(
                                    () => Text(
                                      controller.selectedOption.toString(),
                                      style: Styles.getstyle(
                                          fontweight: FontWeight.bold,
                                          fontsize: _ui.widthPercent(6)),
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/sort.svg',
                                    height: _ui.heightPercent(2.8),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: _ui.widthPercent(0.3),
                          height: _ui.heightPercent(4),
                          color: ColorPallets.fadegrey,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: _ui.heightPercent(0.4)),
                    child: Card(
                      elevation: 2,
                      child: Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: ColorPallets.white,
                        ),
                        height: _ui.heightPercent(17),
                        width: _ui.widthPercent(90),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: _ui.heightPercent(4.5),
                              width: _ui.widthPercent(100),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                color: ColorPallets.themeColor,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: _ui.widthPercent(3)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/location.svg',
                                          height: _ui.heightPercent(2.5),
                                        ),
                                        SizedBox(
                                          width: _ui.widthPercent(3),
                                        ),
                                        Text(
                                          item.location,
                                          style: Styles.getstyle(
                                            fontweight: FontWeight.w600,
                                            fontcolor: ColorPallets.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      CupertinoIcons.eye,
                                      color: ColorPallets.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.all(_ui.widthPercent(3.3)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: Styles.getstyle(
                                            fontsize: _ui.widthPercent(5),
                                            fontweight: FontWeight.w700),
                                      ),
                                      Text(
                                        item.phoneNumber,
                                        style: Styles.getstyle(
                                            fontsize: 18,
                                            fontcolor: ColorPallets.fadegrey2,
                                            fontweight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(_ui.widthPercent(4)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        item.date,
                                        style: Styles.getstyle(
                                            fontsize: _ui.widthPercent(4),
                                            fontcolor: ColorPallets.fadegrey,
                                            fontweight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: _ui.heightPercent(1),
                                      ),
                                      SvgPicture.asset(
                                        'assets/icons/send.svg',
                                        height: _ui.heightPercent(2.5),
                                        width: _ui.widthPercent(2),
                                        alignment: Alignment.center,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Pagination controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    // Implement previous page logic
                  },
                ),
                Text('1 2 ... 99'),
                IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {
                    // Implement next page logic
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
