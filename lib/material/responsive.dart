import 'package:flutter/material.dart';

class ResponsiveUI {
  final BuildContext context;

  ResponsiveUI(this.context);

  // Get screen width
  double get screenWidth => MediaQuery.of(context).size.width;

  // Get screen height
  double get screenHeight => MediaQuery.of(context).size.height;

  // Check if the screen is a mobile screen
  bool get isMobile => screenWidth < 600;

  // Check if the screen is a tablet screen
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;

  // Check if the screen is a desktop screen
  bool get isDesktop => screenWidth >= 1024;

  // Dynamic width based on percentage
  double widthPercent(double percent) => screenWidth * percent / 100;

  // Dynamic height based on percentage
  double heightPercent(double percent) => screenHeight * percent / 100;
}
