import 'package:flutter/material.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';

class NoDataUI extends StatelessWidget {
  const NoDataUI({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Container(
      height: _ui.screenHeight / 1.9,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          ),
        ],
      ),
    );
  }
}
