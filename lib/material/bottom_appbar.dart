import 'package:flutter/material.dart';

/// Custom NotchedShape for the reversed U-notch
class CurvedNotchedRectangle extends NotchedShape {
  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null) {
      return Path()..addRect(host);
    }

    final double notchRadius = guest.width / 2.5;

    final double s1 = 15.0;
    final double s2 = 1.0;

    final double r = notchRadius;
    final double a = -r - s2;
    final double b = host.top - guest.top - s1;

    final double notchCenter = guest.center.dx;

    Path path = Path()..moveTo(host.left, host.top);

    // Left curve
    path.lineTo(notchCenter - 2 * r, host.top);
    path.quadraticBezierTo(
      notchCenter - r,
      host.top,
      notchCenter - r + 3.5,
      host.top + r,
    );

    // Top reversed-U
    path.arcToPoint(
      Offset(notchCenter + r, host.top + r),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    // Right curve
    path.quadraticBezierTo(
      notchCenter + r,
      host.top + 2.5,
      notchCenter + 2.5 * r,
      host.top,
    );

    path.lineTo(host.right, host.top);
    path.lineTo(host.right, host.bottom);
    path.lineTo(host.left, host.bottom);
    path.close();

    return path;
  }
}
