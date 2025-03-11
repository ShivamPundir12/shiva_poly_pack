import 'package:flutter/material.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String productName;
  final String quantity;
  final String date;
  final String status;
  final Function()? onPressed;

  const OrderCard({
    required this.orderId,
    required this.productName,
    required this.quantity,
    required this.date,
    required this.status,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Card(
      shape: Border.all(color: ColorPallets.fadegrey.withOpacity(0.2)),
      // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  orderId,
                  style: Styles.getstyle(
                      fontsize: 16, fontweight: FontWeight.bold),
                ),
                Text(
                  date,
                  style: Styles.getstyle(
                    fontsize: 14,
                    fontcolor: Colors.grey,
                    fontweight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  productName,
                  style: Styles.getstyle(
                    fontsize: 16,
                    fontweight: FontWeight.w600,
                  ),
                ),
                StatusBadge(status: status),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  quantity,
                  style: Styles.getstyle(
                      fontsize: 14, fontcolor: ColorPallets.fadegrey),
                ),
                TextButton(
                  onPressed: onPressed,
                  child: Text(
                    'View Detail',
                    style: Styles.getstyle(
                      fontsize: 14,
                      fontcolor: ColorPallets.themeColor2,
                      fontweight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    switch (status) {
      case 'Cylinder':
        badgeColor = Colors.blue;
        break;
      case 'Printing':
        badgeColor = Colors.orange;
        break;
      case 'Lamination & Metal':
        badgeColor = Colors.pink;
        break;
      case 'Lamination & Poly':
        badgeColor = Colors.lightBlue;
        break;
      case 'Slatting':
        badgeColor = Colors.cyan;
        break;
      case 'Poach Making':
        badgeColor = Colors.redAccent;
        break;
      case 'Dispatch':
        badgeColor = Colors.green;
        break;
      default:
        badgeColor = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: Styles.getstyle(
          fontsize: 14,
          fontcolor: badgeColor,
          fontweight: FontWeight.bold,
        ),
      ),
    );
  }
}
