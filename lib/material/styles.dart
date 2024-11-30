import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static TextStyle getstyle(
      {double? fontsize, FontWeight? fontweight, Color? fontcolor}) {
    return GoogleFonts.mukta(
      fontSize: fontsize ?? 18,
      fontWeight: fontweight ?? FontWeight.normal,
      color: fontcolor ?? Colors.black,
    );
  }
}
