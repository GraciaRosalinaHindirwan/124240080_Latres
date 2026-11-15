
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {

  // Creepster - Main Heading
  static TextStyle heading = GoogleFonts.creepster(
    fontSize: 32,
    color: AppColors.primary,
  );

  // Space Grotesk - Section Heading
  static TextStyle sectionTitle = GoogleFonts.creepster(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Poppins - Body Text
  static TextStyle body = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  // Poppins - Secondary Text
  static TextStyle secondary = GoogleFonts.poppins(
    fontSize: 12,
    color: AppColors.unknown,
  );

  // Poppins - Input Label
  static TextStyle label = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // Poppins - Input Hint
  static TextStyle hint = GoogleFonts.poppins(
    fontSize: 13,
    color: AppColors.unknown,
  );

  // Space Grotesk - Button
  static TextStyle button = GoogleFonts.creepster(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.background,
  );

  // Poppins - Navbar
  static TextStyle navbar = GoogleFonts.poppins(
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );
}
