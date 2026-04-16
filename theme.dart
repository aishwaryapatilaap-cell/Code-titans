import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kNavy     = Color(0xFF0D1B3E);
const Color kRed      = Color(0xFFC0392B);
const Color kGold     = Color(0xFF8B6914);
const Color kWhite    = Color(0xFFFFFFFF);
const Color kOffWhite = Color(0xFFF5F4F0);
const Color kDark     = Color(0xFF1A1A1A);
const Color kMuted    = Color(0xFF6B6B6B);

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: kNavy,
    secondary: kRed,
    tertiary: kGold,
    surface: kWhite,
  ),
  textTheme: GoogleFonts.interTextTheme().copyWith(
    displayLarge: GoogleFonts.playfairDisplay(
      fontSize: 56, fontWeight: FontWeight.w700, color: kNavy, height: 1.1),
    displayMedium: GoogleFonts.playfairDisplay(
      fontSize: 40, fontWeight: FontWeight.w700, color: kNavy, height: 1.2),
    headlineMedium: GoogleFonts.inter(
      fontSize: 24, fontWeight: FontWeight.w600, color: kNavy),
    bodyLarge: GoogleFonts.inter(fontSize: 16, color: kDark, height: 1.7),
    bodyMedium: GoogleFonts.inter(fontSize: 14, color: kMuted, height: 1.6),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kNavy,
      foregroundColor: kWhite,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  ),
  scaffoldBackgroundColor: kWhite,
);
