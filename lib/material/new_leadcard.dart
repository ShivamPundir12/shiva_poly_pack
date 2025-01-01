import 'package:flutter/material.dart';
import 'package:shiva_poly_pack/material/responsive.dart';

class PouchCard extends StatelessWidget {
  final String name;
  final String location;
  final String phoneNumber;
  final String kindOfPouch;
  final String sizeOfPouch;
  final int quantity;
  final String createdDate;

  const PouchCard({
    Key? key,
    required this.name,
    required this.location,
    required this.phoneNumber,
    required this.kindOfPouch,
    required this.sizeOfPouch,
    required this.quantity,
    required this.createdDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section with location and date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_pin, color: Colors.blue),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  createdDate,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const Divider(),
            // Main Information
            Container(
              width: _ui.widthPercent(42),
              child: Text(
                name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Phone: $phoneNumber',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text('Kind of Pouch: $kindOfPouch'),
            Text('Required Size: $sizeOfPouch'),
            Text('Quantity: $quantity'),
          ],
        ),
      ),
    );
  }
}
