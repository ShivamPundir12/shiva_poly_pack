import 'package:flutter/material.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';

class NotificationMenu extends StatelessWidget {
  final VoidCallback onDisable;
  final VoidCallback onAllowAll;
  final VoidCallback onFestive;

  const NotificationMenu({
    Key? key,
    required this.onDisable,
    required this.onAllowAll,
    required this.onFestive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Material(
      color: ColorPallets.fadegrey.withOpacity(0.4),
      child: Stack(
        children: [
          // Close menu when tapping outside
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Positioned(
            top: _ui.heightPercent(9), // Adjust position as per your design
            right: _ui.widthPercent(15), // Adjust position as per your design
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 4,
              child: Container(
                padding: const EdgeInsets.all(8),
                width: _ui.widthPercent(65),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: onDisable,
                      child: Row(
                        children: const [
                          Icon(Icons.notifications_off, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            'Disable Notifications',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _ui.heightPercent(1.3),
                    ),
                    GestureDetector(
                      onTap: onAllowAll,
                      child: Row(
                        children: const [
                          Icon(Icons.notifications_active, color: Colors.blue),
                          SizedBox(width: 10),
                          Text(
                            'Allow All Notifications',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _ui.heightPercent(1.3),
                    ),
                    GestureDetector(
                      onTap: onFestive,
                      child: Row(
                        children: const [
                          Icon(Icons.notifications, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            'Only Festive Notifications',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
