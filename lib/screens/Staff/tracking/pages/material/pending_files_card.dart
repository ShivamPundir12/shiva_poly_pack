import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shiva_poly_pack/data/controller/pending_files.dart';
import 'package:shiva_poly_pack/data/model/pending_files.dart';
import 'package:shiva_poly_pack/routes/app_routes.dart';

import '../../../../../data/model/follow_up.dart';
import '../../../../../material/color_pallets.dart';
import '../../../../../material/responsive.dart';
import '../../../../../material/styles.dart';

class PendingFilesCard extends StatelessWidget {
  PendingFilesCard({super.key, required this.item});
  final PendingFile item;

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    final PendingFilesController _controller =
        Get.find<PendingFilesController>();

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
                          item.location,
                          style: Styles.getstyle(
                            fontweight: FontWeight.w600,
                            fontcolor: ColorPallets.white,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(Routes.add_new_cus),
                      child: Icon(
                        Icons.edit,
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
                          fontweight: FontWeight.w700,
                        ),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _controller.date.value,
                        style: Styles.getstyle(
                            fontsize: _ui.widthPercent(4),
                            fontcolor: ColorPallets.fadegrey,
                            fontweight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: _ui.heightPercent(1),
                      ),
                      Text(
                        _controller.time.value,
                        style: Styles.getstyle(
                            fontsize: _ui.widthPercent(3.5),
                            fontcolor: ColorPallets.fadegrey,
                            fontweight: FontWeight.w700),
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
