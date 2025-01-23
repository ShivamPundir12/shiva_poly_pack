import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../material/contactOptions.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ContactOption(
              icon: Icons.phone,
              label: 'Contact Us',
              onTap: () {
                print('Contact Us tapped');
              },
            ),
            SizedBox(width: 20),
            ContactOption(
              icon: FontAwesomeIcons.whatsapp,
              label: 'WhatsApp Us',
              onTap: () {
                print('WhatsApp Us tapped');
              },
            ),
          ],
        ),
      ),
    );
  }
}
