import 'package:flutter/material.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/styles.dart';

class ContactOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ContactOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150, // Set width for the square
        height: 150, // Set height equal to width for square
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: label == 'Contact Us'
                ? Colors.orange.shade500
                : Colors.greenAccent.shade700,
          ),
          borderRadius: BorderRadius.circular(22),
          color: label == 'Contact Us'
              ? Colors.orange.shade100
              : Colors.greenAccent.shade100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: ColorPallets.themeColor2),
            SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Styles.getstyle(
                  fontcolor: ColorPallets.fadegrey2,
                  fontweight: FontWeight.bold,
                  fontsize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
