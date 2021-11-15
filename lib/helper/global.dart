import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Global {
  static TextStyle titleOfList = GoogleFonts.hindSiliguri(
      color: Colors.black, fontWeight: FontWeight.w600);

  static TextStyle titleOfCategory = GoogleFonts.hindSiliguri(
      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w700);

  static TextStyle titleOfAppbar = GoogleFonts.hindSiliguri(
      color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600);

  static TextStyle titleCarosal = GoogleFonts.hindSiliguri(
      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w500);

  static TextStyle titleName = GoogleFonts.roboto(
      color: defaultColor, fontSize: 20.0, fontWeight: FontWeight.bold);

  static var bottomSelectedNavText = GoogleFonts.roboto(
      color: defaultColor, fontSize: 16.0, fontWeight: FontWeight.bold);

  static TextStyle gridTitleName = GoogleFonts.hindSiliguri(
      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w500);

  static var bottomUnselectedNavText =
      GoogleFonts.roboto(color: defaultColor, fontSize: 13.0);

  static TextStyle subscriptionFeatureText = GoogleFonts.hindSiliguri(
      color: defaultColor, fontSize: 20.0, fontWeight: FontWeight.w600);

  static Color defaultColor = Color.fromRGBO(0, 116, 255, 1);
  static Color backgroundColor = Colors.blue.shade50;
}
