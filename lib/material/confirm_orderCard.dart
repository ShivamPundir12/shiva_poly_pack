import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/confirmOrder.dart';
import 'package:shiva_poly_pack/data/model/cus_pending_order.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/indicator.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';

class ProductCard extends GetView<ConfirmorderController> {
  final PendingOrderData pendingOrderData;

  ProductCard({super.key, required this.pendingOrderData});

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: _ui.widthPercent(1.2), vertical: _ui.heightPercent(0.4)),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.shade400),
        ),
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(_ui.heightPercent(0.8)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pendingOrderData.uniqueNumber.toString(),
                    style: Styles.getstyle(
                      fontweight: FontWeight.bold,
                      fontcolor: ColorPallets.fadegrey,
                      fontsize: _ui.widthPercent(4),
                    ),
                  ),
                  Text(
                      controller
                          .formatDate(pendingOrderData.dispatchDate.toString()),
                      style: Styles.getstyle(
                          fontsize: _ui.widthPercent(4),
                          fontweight: FontWeight.w700)),
                ],
              ),
              Divider(),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Container(
                    width: _ui.widthPercent(20),
                    height: _ui.heightPercent(14),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: controller.baseUrl +
                            '/' +
                            pendingOrderData.orderPic.toString(),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProgressIndicatorWidget(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  // Product Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: _ui.widthPercent(46),
                          child: Text(
                            pendingOrderData.jobName.toString(),
                            softWrap: true,
                            style: TextStyle(
                              fontSize: _ui.widthPercent(4),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(pendingOrderData.pouchType.toString(),
                            style: Styles.getstyle(
                                fontsize: _ui.widthPercent(4),
                                fontweight: FontWeight.bold,
                                fontcolor: ColorPallets.themeColor)),
                        SizedBox(height: 4),
                        Text(
                          pendingOrderData.stage.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: _ui.widthPercent(62),
                                child: SliderTheme(
                                  data: SliderThemeData(
                                    activeTrackColor: ColorPallets.themeColor2,
                                    inactiveTrackColor: Colors.grey[300],
                                    trackHeight: 2,
                                    thumbShape: RingSliderThumb(),
                                    trackShape: CustomTrackShape(),
                                    thumbColor: ColorPallets.themeColor2,
                                    overlayColor: Colors.transparent,
                                    tickMarkShape: RoundSliderTickMarkShape(
                                        tickMarkRadius: 4),
                                    activeTickMarkColor:
                                        ColorPallets.themeColor2,
                                    inactiveTickMarkColor: Colors.grey[400],
                                  ),
                                  child: Slider(
                                    value: double.parse(pendingOrderData
                                        .stageNumber
                                        .toString()),
                                    min: 0,
                                    max: 6,
                                    divisions: 6,
                                    onChanged: (value) {
                                      controller.sliderProgress(
                                        double.parse(
                                          pendingOrderData.stageNumber
                                              .toString(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RingSliderThumb extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(16, 16);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    canvas.drawCircle(
        center,
        8,
        Paint()
          ..color = Colors.yellow
          ..style = PaintingStyle.fill);
    canvas.drawCircle(
        center,
        8,
        Paint()
          ..color = ColorPallets.themeColor2
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
    canvas.drawCircle(
        center,
        6,
        Paint()
          ..color = ColorPallets.themeColor2
          ..style = PaintingStyle.fill);
  }
}

class CustomTrackShape extends SliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    required TextDirection textDirection,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    if (sliderTheme.trackHeight == null) return;

    final Rect trackRect = Rect.fromLTWH(
      offset.dx,
      offset.dy + (parentBox.size.height - sliderTheme.trackHeight!) / 2,
      parentBox.size.width,
      sliderTheme.trackHeight!,
    );

    final Paint paint = Paint()
      ..color = ColorPallets.themeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    context.canvas.drawLine(
      Offset(trackRect.left, trackRect.center.dy),
      Offset(trackRect.right, trackRect.center.dy),
      paint,
    );
  }

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 2;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
