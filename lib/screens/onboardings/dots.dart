import 'package:flutter/material.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';

class DotIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  DotIndicator({required this.itemCount, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(itemCount, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: index == currentIndex ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color:
                index == currentIndex ? ColorPallets.themeColor : Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
