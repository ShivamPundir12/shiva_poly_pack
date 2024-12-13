import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/material/responsive.dart';

class LoadingView {
  /// Show a simple progress indicator using Get.dialog
  static void show() {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(), // Simple loading indicator
      ),
      barrierDismissible: false, // Prevent dismissing by tapping outside
    );
  }

  /// Hide the progress indicator
  static void hide() {
    if (Get.isDialogOpen ?? false) {
      Get.back(); // Close the current dialog
    }
  }
}

class ProgressIndicatorWidget extends StatelessWidget {
  final double? size;
  final Color? color;

  const ProgressIndicatorWidget({
    Key? key,
    this.size = 50.0, // Default size is 50.0
    this.color = Colors.blue, // Default color is blue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveUI(context).heightPercent(50),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 5.0, // Controls the thickness of the progress circle.
          valueColor:
              AlwaysStoppedAnimation<Color>(color!), // Color of the spinner
          semanticsLabel: 'Loading...',
          backgroundColor:
              Colors.grey.shade300, // Background color of the circle
          value: null, // No value for an indeterminate progress.
        ),
      ),
    );
  }
}
