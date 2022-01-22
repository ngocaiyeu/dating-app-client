import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Mytheme {
  static final TextStyle textIntro = GoogleFonts.nunito(
      fontSize: 48, fontWeight: FontWeight.w800, color: Colors.white);
  static final TextStyle textIntroSmall = GoogleFonts.nunito(
      fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white);
  static final TextStyle textLogin = GoogleFonts.nunito(
      fontSize: 48, fontWeight: FontWeight.w800, color: Colors.green);
  static final TextStyle textLoginSmall = GoogleFonts.nunito(
      fontSize: 20, fontWeight: FontWeight.w400, color: Colors.green);
  static final TextStyle hAppTitle = GoogleFonts.grandHotel(
      fontSize: 25, color: Colors.pink, fontWeight: FontWeight.w500);
  static final TextStyle textName = GoogleFonts.dongle(
      fontSize: 25, color: Colors.black, fontWeight: FontWeight.w500);
  static const kPrimaryColor = Color(0xFFFF7643);
  static const kBackgroundColor = Color(0xFFFFFFFF);
  static const kSecondaryColor = Color(0xFF979797);
  static const kTextColor = Color(0xFF272727);
  static const kMenuColor = Color(0xFFFF7643);
  static const kShadowColor = Color(0xFFEDEDED);
  static const kAnimationDuration = Duration(milliseconds: 200);

  static const double kBorderRadius = 28;
}
