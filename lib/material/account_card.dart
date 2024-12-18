import 'package:flutter/material.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';

class AccountCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final bool isSelected;

  const AccountCard({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _ui.widthPercent(2)),
      padding: EdgeInsets.symmetric(vertical: _ui.heightPercent(3)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? ColorPallets.themeColor : Colors.black12,
          width: 2,
        ),
        color: isSelected
            ? ColorPallets.themeColor.withOpacity(0.1)
            : ColorPallets.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            scale: _ui.widthPercent(6),
          ),
          SizedBox(width: _ui.widthPercent(2)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Styles.getstyle(
                  fontsize: _ui.widthPercent(4),
                  fontweight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  description,
                  style: Styles.getstyle(
                    fontsize: _ui.widthPercent(3.3),
                    fontweight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          if (isSelected)
            Icon(
              Icons.check_circle,
              color: ColorPallets.themeColor,
            ),
        ],
      ),
    );
  }
}
