import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Display Font (Lexend)
  static TextStyle get displayFont => GoogleFonts.lexend();
  
  // Headings
  static TextStyle heading1(BuildContext context) => displayFont.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.015,
    height: 1.2,
  );
  
  static TextStyle heading2(BuildContext context) => displayFont.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.015,
    height: 1.2,
  );
  
  static TextStyle heading3(BuildContext context) => displayFont.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.015,
    height: 1.2,
  );
  
  // Body Text
  static TextStyle bodyLarge(BuildContext context) => displayFont.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    height: 1.8,
  );
  
  static TextStyle bodyMedium(BuildContext context) => displayFont.copyWith(
    fontSize: 17,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  
  static TextStyle bodySmall(BuildContext context) => displayFont.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  
  // Song Title
  static TextStyle songTitle(BuildContext context) => displayFont.copyWith(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  
  // Song Preview
  static TextStyle songPreview(BuildContext context) => displayFont.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    height: 1.3,
  );
  
  // Lyrics
  static TextStyle lyrics(BuildContext context) => displayFont.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    height: 1.8,
  );
  
  static TextStyle lyricsLarge(BuildContext context) => displayFont.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    height: 1.8,
  );
  
  // Labels
  static TextStyle label(BuildContext context) => displayFont.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
  
  static TextStyle labelSmall(BuildContext context) => displayFont.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
  
  // Button Text
  static TextStyle button(BuildContext context) => displayFont.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
}

