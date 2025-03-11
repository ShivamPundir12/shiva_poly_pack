import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shiva_poly_pack/data/controller/ledgercontroller.dart';
import 'package:shiva_poly_pack/data/model/ledger.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';

import '../data/helper/pdf_helper.dart';
import '../data/services/validation.dart';

class LedgerCard extends GetView<LedgerReportController> {
  final int index;
  final bool isExpanded;
  final LedgerData item;
  const LedgerCard(
      {super.key,
      required this.index,
      required this.isExpanded,
      required this.item});

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Card(
        child: Container(
          alignment: Alignment.center,
          color: index.isEven ? Colors.grey[300] : ColorPallets.white,
          child: Column(
            children: [
              GestureDetector(
                onTap: () => controller.toggleExpand(index),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: _ui.widthPercent(5),
                        child: Text(
                          '${index + 1}.',
                          style: Styles.getstyle(
                              fontsize: _ui.widthPercent(3),
                              fontweight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: _ui.widthPercent(52),
                        child: Text(
                          item.orderName.toString(),
                          style: Styles.getstyle(
                              fontsize: _ui.widthPercent(3),
                              fontweight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        formatDate(item.createdDate.toString()),
                        textAlign: TextAlign.right,
                        style: Styles.getstyle(
                            fontsize: _ui.widthPercent(3),
                            fontweight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: _ui.widthPercent(4),
                      ),
                      isExpanded
                          ? Transform.rotate(
                              angle: pi / 2,
                              child: SvgPicture.asset(
                                'assets/icons/list.svg',
                                height: _ui.heightPercent(1.6),
                                width: _ui.widthPercent(1.6),
                              ),
                            )
                          : SvgPicture.asset(
                              'assets/icons/list.svg',
                              height: _ui.heightPercent(1.6),
                              width: _ui.widthPercent(1.6),
                            ),
                    ],
                  ),
                ),
              ),
              // Expanded content
              if (isExpanded)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.grey[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await PDFHelper.previewAndDownloadPDF(
                            context: context,
                            url:
                                '${controller.baseUrl}/${item.ledger?.replaceAll(' ', '%20')}',
                            fileName: "${item.orderName}",
                          );
                          print(
                              '${controller.baseUrl}/${item.ledger?.replaceAll(' ', '%20')}');
                        },
                        child: Card(
                          color: ColorPallets.white,
                          child: Container(
                            // width: _ui.widthPercent(),
                            padding: EdgeInsets.symmetric(
                                horizontal: _ui.widthPercent(4)),
                            height: _ui.heightPercent(6),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.download,
                                  color: ColorPallets.themeColor,
                                ),
                                SizedBox(
                                  width: _ui.widthPercent(2),
                                ),
                                Text(
                                  'Download Ledger',
                                  style: Styles.getstyle(
                                    fontcolor: ColorPallets.fadegrey2,
                                    fontweight: FontWeight.bold,
                                    fontsize: _ui.widthPercent(3),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
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
