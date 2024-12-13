import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/new_leads.dart';
import 'package:shiva_poly_pack/data/model/new_leads.dart';

import '../../../../../data/model/follow_up.dart';
import '../../../../../material/color_pallets.dart';
import '../../../../../material/responsive.dart';
import '../../../../../material/styles.dart';

class NewLeadsCard extends StatelessWidget {
  NewLeadsCard({
    super.key,
    required this.item,
    this.onTap,
    required this.isExpanded,
  });
  final Lead? item;
  final Function()? onTap;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);

    return Card(
      elevation: 2,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: ColorPallets.white,
        ),
        width: _ui.widthPercent(90),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
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
                    horizontal: _ui.widthPercent(3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/location.svg',
                            height: _ui.heightPercent(2.5),
                          ),
                          SizedBox(
                            width: _ui.widthPercent(3),
                          ),
                          Text(
                            item?.location.capitalize ?? '',
                            style: Styles.getstyle(
                              fontweight: FontWeight.w600,
                              fontcolor: ColorPallets.white,
                            ),
                          ),
                        ],
                      ),
                      // Icon(
                      //   CupertinoIcons.eye,
                      //   color: ColorPallets.white,
                      // ),
                    ],
                  ),
                ),
              ),

              // Main Row with Name and Date
              Padding(
                padding: EdgeInsets.all(_ui.widthPercent(3.3)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item?.name.capitalize ?? '',
                          style: Styles.getstyle(
                              fontsize: _ui.widthPercent(5),
                              fontweight: FontWeight.w700),
                        ),
                        Text(
                          item?.phoneNumber ?? '',
                          style: Styles.getstyle(
                              fontsize: 18,
                              fontcolor: ColorPallets.fadegrey2,
                              fontweight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Text(
                      item?.kindofPouch ?? "",
                      style: Styles.getstyle(
                          fontsize: _ui.widthPercent(4),
                          fontcolor: ColorPallets.fadegrey,
                          fontweight: FontWeight.w700),
                    )
                  ],
                ),
              ),

              // Expandable Section
              if (isExpanded) ...[
                Divider(color: Colors.grey),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: _ui.widthPercent(3.3)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "More Details",
                        style: Styles.getstyle(
                            fontsize: _ui.widthPercent(4),
                            fontweight: FontWeight.w600),
                      ),
                      SizedBox(height: _ui.heightPercent(1)),
                      _moreDetail(
                        ui: _ui,
                        title: 'Kind Of Pouch : ',
                        subtitle: item?.kindofPouch ?? '',
                      ),
                      _moreDetail(
                        ui: _ui,
                        title: 'Required Size Of Pouch : ',
                        subtitle: item?.requirePouchSize ?? '',
                      ),
                      _moreDetail(
                        ui: _ui,
                        title: 'Quantity Of Pouch : ',
                        subtitle: item?.pouchQuantityPerSize ?? '',
                      ),
                    ],
                  ),
                ),
              ],

              // Expand/Collapse Icon Button
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(
                  right: _ui.widthPercent(3),
                  bottom: _ui.widthPercent(3),
                ),
                child: InkWell(
                  onTap: onTap,
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: CircleBorder(
                        side: BorderSide(color: ColorPallets.fadegrey2),
                      ),
                    ),
                    child: Transform.rotate(
                      angle: isExpanded ? pi / -2 : pi / 2,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: _ui.widthPercent(5),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _moreDetail(
      {required ResponsiveUI ui,
      required String title,
      required String subtitle}) {
    return Row(
      children: [
        Text(
          title,
          style: Styles.getstyle(
            fontcolor: ColorPallets.fadegrey,
            fontsize: ui.widthPercent(4),
            fontweight: FontWeight.w600,
          ),
        ),
        SizedBox(width: ui.heightPercent(0.5)),
        Text(
          subtitle,
          style: Styles.getstyle(
            fontsize: ui.widthPercent(4.3),
            fontweight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
