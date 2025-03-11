import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/material/responsive.dart';

class ImagePreview {
  void showImagePreview(String imageUrl, BuildContext context) {
    Get.dialog(AlertDialog(
      content: Container(
        width: ResponsiveUI(context).screenWidth,
        height: ResponsiveUI(context).heightPercent(50),
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(),
        ),
        child: Container(
          width: ResponsiveUI(context).screenWidth,
          height: ResponsiveUI(context).heightPercent(80),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.fill,
              placeholder: (context, url) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProgressIndicatorWidget(),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
