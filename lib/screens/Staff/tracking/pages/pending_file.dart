import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';
import 'package:shiva_poly_pack/screens/Staff/tracking/pages/material/pending_files_card.dart';

import '../../../../data/model/follow_up.dart';
import '../../../../material/color_pallets.dart';
import 'material/follow_up_card.dart';

class PendingFile extends StatelessWidget {
  PendingFile({super.key});
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
      appBar: AppBar(
        backgroundColor: ColorPallets.white,
        bottom: PreferredSize(
          preferredSize: Size(
            _ui.widthPercent(100),
            _ui.heightPercent(2),
          ),
          child: Divider(
            indent: _ui.widthPercent(6),
            endIndent: _ui.widthPercent(6),
            color: Colors.grey.shade400,
            thickness: 1.2,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Pending Files',
          style: Styles.getstyle(
            fontweight: FontWeight.bold,
            fontsize: _ui.widthPercent(6),
          ),
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
                          onTap: () {},
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
                                  Text(
                                    'A-Z',
                                    style: Styles.getstyle(
                                        fontweight: FontWeight.bold,
                                        fontsize: _ui.widthPercent(6)),
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
                    child: PendingFilesCard(item: item),
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