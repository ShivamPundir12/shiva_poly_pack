import 'package:flutter/material.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
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
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(productName, style: TextStyle(fontSize: 16)),
                StatusBadge(status: status),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(quantity, style: TextStyle(color: Colors.grey)),
                TextButton(
                  onPressed: onPressed,
                  child: Text(
                    'View Detail',
                    style: Styles.getstyle(
                        fontsize: 14,
                        fontcolor: ColorPallets.themeColor2,
                        fontweight: FontWeight.w500),
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
        style: TextStyle(color: badgeColor),
      ),
    );
  }
}
