import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';

class HomeCard extends StatelessWidget {
  final String icon;
  final String title;
  final Color backgroundColor;
  final VoidCallback onTap;

  const HomeCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.backgroundColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Container(
          height: _ui.heightPercent(50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              Transform.rotate(
                angle: pi / -1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipPath(
                    clipper: CurvedClipper(),
                    child: Container(
                      height: _ui.heightPercent(24),
                      color: backgroundColor.withOpacity(0.1),
                    ),
                  ),
                ),
              ),
              // Icon and Title
              Container(
                width: _ui.screenWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      icon,
                      alignment: Alignment.center,
                      height: _ui.heightPercent(6),
                      width: _ui.widthPercent(8),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Styles.getstyle(
                        fontweight: FontWeight.bold,
                        fontsize: _ui.widthPercent(4.2),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // Start from top-left corner
    path.lineTo(0, size.height * 0.5);

    // Create a more rounded curve
    path.quadraticBezierTo(
        size.width * 0.5, // Horizontal position of the curve's peak
        size.height * 0.8, // Vertical depth of the curve
        size.width, // End horizontal position (right edge)
        size.height * 0.5 // End vertical position (anchor point)
        );

    // Close the path at the top-right corner
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
