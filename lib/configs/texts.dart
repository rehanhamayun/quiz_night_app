import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget normalText({
  String? text,
  Color? color,
  double? size,
  FontWeight? fontWeight,
}) {
  return Text(
    text!,
    style: GoogleFonts.poppins(
      //fontFamily: "quick_semi",
      fontSize: size,
      color: color,
    ),
  );
}

Widget headingText({
  String? text,
  Color? color,
  double? size,
  FontWeight? fontWeight,
}) {
  return Text(
    text!,
    style: GoogleFonts.poppins(
      //fontFamily: "quick_bold",
      fontSize: size,
      color: color,
    ),
  );
}
