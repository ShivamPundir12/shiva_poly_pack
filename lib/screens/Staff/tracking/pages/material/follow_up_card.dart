import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shiva_poly_pack/data/controller/account_type.dart';

import '../../../../../data/model/follow_up.dart';
import '../../../../../material/color_pallets.dart';
import '../../../../../material/responsive.dart';
import '../../../../../material/styles.dart';

class FollowUpCard extends StatelessWidget {
  FollowUpCard({super.key, required this.item, this.onTap, this.eyeonTap});
  final FollowupModel item;
  final Function()? onTap;
  final Function()? eyeonTap;

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);

    return Card(
      elevation: 2,
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: ColorPallets.white,
        ),
        // height: _ui.heightPercent(17),
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
                padding: EdgeInsets.symmetric(horizontal: _ui.widthPercent(3)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          item.location.toString(),
                          style: Styles.getstyle(
                            fontweight: FontWeight.w600,
                            fontcolor: ColorPallets.white,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: eyeonTap,
                      child: Icon(
                        CupertinoIcons.eye,
                        color: ColorPallets.white,
                      ),
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
                  padding: EdgeInsets.all(_ui.widthPercent(3.3)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: Styles.getstyle(
                            fontsize: _ui.widthPercent(5),
                            fontweight: FontWeight.w700),
                      ),
                      Text(
                        "Tag: ${item.tagsId?.first}",
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        item.createdDate.toString().replaceRange(11, 26, ''),
                        style: Styles.getstyle(
                            fontsize: _ui.widthPercent(4),
                            fontcolor: ColorPallets.fadegrey,
                            fontweight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: _ui.heightPercent(1),
                      ),
                      InkWell(
                        onTap: onTap,
                        child: SvgPicture.asset(
                          'assets/icons/send.svg',
                          height: _ui.heightPercent(2.5),
                          width: _ui.widthPercent(2),
                          alignment: Alignment.center,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
