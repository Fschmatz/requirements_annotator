import 'package:flutter/material.dart';

ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: const Color(0xFFFFFFFF),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    colorScheme: const ColorScheme.light(
        background: Color(0xFFF0F2F2),
        primary: Colors.cyan,
        secondary: Colors.cyan,
    ),
    appBarTheme: const AppBarTheme(
        color: Color(0xFFFFFFFF),
        elevation: 0,
        iconTheme: IconThemeData(
            color: Color(0xFF000000)
        ),
        titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Color(0xFF000000))),
    cardTheme: const CardTheme(
      color: Color(0xFFF6F6F6),
    ),
    bottomAppBarColor: const Color(0xFFE9E8E8),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Color(0xFFE9E8E8),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      actionTextColor: Color(0xFF68DEDA),
    ),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFFE9E8E8),
        indicatorColor: Colors.cyan,
        iconTheme: MaterialStateProperty.all(
            const IconThemeData(color: Color(0xFF050505),)
        ),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFF050505), fontWeight: FontWeight.w500))),
    bottomSheetTheme:
    const BottomSheetThemeData(modalBackgroundColor: Color(0xFFFFFFFF)));

ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF202124),
    scaffoldBackgroundColor: const Color(0xFF202124),
    colorScheme: const ColorScheme.dark(
        background: Color(0xFF202124),
        primary:  Color(0xFF68DEDA),
        secondary: Color(0xFF68DEDA)
    ),
    appBarTheme: const AppBarTheme(
        color: Color(0xFF202124),
        elevation: 0,
        iconTheme: IconThemeData(
            color: Color(0xFFFFFFFF)
        ),
        titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Color(0xFFFFFFFF))),
    cardTheme: const CardTheme(
      color: Color(0xFF313034),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFF313034),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Color(0xFF18181B),
    ),
    bottomAppBarColor: const Color(0xFF18181B),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFFF0F0F0),
      actionTextColor: Colors.cyan,
    ),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF18181B),
        indicatorColor: const Color(0xFF68DEDA),
        iconTheme: MaterialStateProperty.all(
            const IconThemeData(color: Color(0xFFEAEAEA),)
        ),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFFEAEAEA), fontWeight: FontWeight.w500))),
    bottomSheetTheme:
    const BottomSheetThemeData(modalBackgroundColor: Color(0xFF202124)));
