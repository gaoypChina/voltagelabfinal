import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Global {
  static TextStyle titleOfList = GoogleFonts.hindSiliguri(
      color: Colors.black, fontWeight: FontWeight.w600);

  static TextStyle titleOfCategory = GoogleFonts.hindSiliguri(
      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w700);

  static TextStyle bntitleOfAppbar = GoogleFonts.hindSiliguri(
      color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600);

  static TextStyle entitleOfAppbar = GoogleFonts.lato(
      color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600);

  static TextStyle titleCarosal = GoogleFonts.hindSiliguri(
      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w500);

  static TextStyle entitleName = GoogleFonts.lato(
      color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold);

  static var bottomSelectedNavText = GoogleFonts.hindSiliguri(
      color: defaultColor, fontSize: 16.0, fontWeight: FontWeight.bold);

  static TextStyle gridTitleName = GoogleFonts.hindSiliguri(
      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w500);

  static var bottomUnselectedNavText =
      GoogleFonts.hindSiliguri(color: defaultColor, fontSize: 13.0);

  static TextStyle subscriptionFeatureText = GoogleFonts.hindSiliguri(
      color: defaultColor, fontSize: 20.0, fontWeight: FontWeight.w600);

  static TextStyle gridtopfont = GoogleFonts.hindSiliguri(
      color: Colors.black45, fontSize: 12.0, fontWeight: FontWeight.normal);

  static TextStyle bncategorySearchhintText = GoogleFonts.hindSiliguri(
      color: Colors.black45, fontSize: 16.0, fontWeight: FontWeight.normal);

  static TextStyle encategorySearchhintText = GoogleFonts.lato(
      color: Colors.black45, fontSize: 16.0, fontWeight: FontWeight.normal);

  static TextStyle bncategoryTitleText = GoogleFonts.hindSiliguri(
      color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600);

  static TextStyle encategoryTitleText = GoogleFonts.lato(
      color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600);

  static Color defaultColor = Color.fromRGBO(0, 116, 255, 1);
  static Color appBarColor = Colors.white;
  static Color backgroundColor = Colors.blue.shade50;
}
