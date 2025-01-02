import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppThemes {
  final AppColors _appColors;

  AppThemes({required AppColors appColors}) : _appColors = appColors;

  ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _appColors.kPrimaryColor,
          outline: _appColors.kBorderColor,
          secondary: _appColors.kSecondaryColor,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            foregroundColor: Colors.black,
            centerTitle: true,
            titleTextStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
        fontFamily: 'Poppins',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            backgroundColor: Colors.transparent,
            foregroundColor: _appColors.kWhiteColor,
            padding: EdgeInsets.zero,
            textStyle:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      );
}
