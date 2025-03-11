import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';

class reuseable_button extends StatelessWidget {
  reuseable_button({
    super.key,
    required ResponsiveUI ui,
    this.isDisabled,
    required this.button_text,
  }) : _ui = ui;

  final ResponsiveUI _ui;
  final bool? isDisabled;
  final String button_text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: _ui.heightPercent(7.5),
      decoration: ShapeDecoration(
        color: isDisabled == true
            ? ColorPallets.fadegrey2
            : ColorPallets.themeColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        button_text,
        style: Styles.getstyle(
          fontcolor: ColorPallets.white,
          fontsize: 18,
          fontweight: FontWeight.bold,
        ),
      ),
    );
  }
}
