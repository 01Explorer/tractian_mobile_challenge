import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/helpers/constansts.dart';

ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkerColor,
      iconTheme: IconThemeData(color: Colors.white),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: companiesColors,
    ),
    expansionTileTheme: ExpansionTileThemeData(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      shape: Border(
        left: BorderSide(
          color: Colors.grey[400]!,
          width: 1,
        ),
      ),
      collapsedShape: Border(
        left: BorderSide(
          color: Colors.grey[400]!,
          width: 1,
        ),
      ),
      iconColor: companiesColors,
      collapsedIconColor: companiesColors,
    ),
  );
}
