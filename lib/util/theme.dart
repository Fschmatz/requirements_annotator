import 'package:flutter/material.dart';

ThemeData light = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.light,
    primaryColor: const Color(0xFFFFFFFF),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    colorScheme: const ColorScheme.light(
        background: Color(0xFFF0F2F2),
        primary: Colors.cyan,
        onPrimary:  Color(0xFFFFFFFF),
        secondary: Colors.cyan,
    ),
    listTileTheme: const ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    appBarTheme: const AppBarTheme(
        color: Color(0xFFFFFFFF),
      surfaceTintColor: Color(0xFFFFFFFF),
        ),
    cardTheme: const CardTheme(
      surfaceTintColor: Color(0xFFF6F6F6),
      color: Color(0xFFF6F6F6),

    ),
    popupMenuTheme: const PopupMenuThemeData(
      color:  Color(0xFFF6F6F6),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusColor:  Colors.cyan,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.cyan,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(8.0)),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(8.0))),
    bottomAppBarColor: const Color(0xFFFFFFFF),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Color(0xFFFFFFFF),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFFFFFFFF),     
    ),
    snackBarTheme: const SnackBarThemeData(
      actionTextColor: Color(0xFF68DEDA),
    ),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFFFFFFFF),
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
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1B1B1D),
    scaffoldBackgroundColor: const Color(0xFF1B1B1D),
    colorScheme: const ColorScheme.dark(
        background: Color(0xFF1B1B1D),
        primary:  Color(0xFF68DEDA),
        onPrimary: Color(0xFF1B3A39),
        secondary: Color(0xFF68DEDA)
    ),
    listTileTheme: const ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: Color(0xFF323234),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Color(0xFF1B1B1D),
        color: Color(0xFF1B1B1D),
        ),
    cardTheme: const CardTheme(
      surfaceTintColor:  Color(0xFF242426),
      color: Color(0xFF242426),     
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusColor: const Color(0xFF68DEDA),
       focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF68DEDA),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[850]!,
            ),
            borderRadius: BorderRadius.circular(8.0)),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[850]!,
            ),
            borderRadius: BorderRadius.circular(8.0))),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFF242426),      
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Color(0xFF1B1B1D),
    ),
    bottomAppBarColor: const Color(0xFF1B1B1D),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFFF0F0F0),
      actionTextColor: Colors.cyan,
    ),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF1B1B1D),
        indicatorColor: const Color(0xFF68DEDA),
        iconTheme: MaterialStateProperty.all(
            const IconThemeData(color: Color(0xFFEAEAEA),)
        ),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFFEAEAEA), fontWeight: FontWeight.w500))),
    bottomSheetTheme:
    const BottomSheetThemeData(modalBackgroundColor: Color(0xFF1B1B1D)));
