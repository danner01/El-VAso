import 'package:flutter/material.dart';

const textColor = Color.fromARGB(255, 124, 126, 126);
const whiteColor = Color(0xffF9F9F9);
const blackColor = Color.fromRGBO(31, 31, 31, 1);

const primaryColor = Color.fromRGBO(33, 60, 219, 1);
 
class MyThemes {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: whiteColor,
    canvasColor: Colors.grey.shade600,
    cardColor: const Color(0xffF5F5F5),
    dividerTheme: const DividerThemeData(color: Colors.black),
    // appBarTheme: const AppBarTheme (
    //   backgroundColor: primaryColor,
    //   foregroundColor: Colors.white,

    // ),
    primaryColor: primaryColor,
    hintColor: Colors.grey.shade200,
    indicatorColor: const Color(0xFF3E6F89),
    colorScheme: const ColorScheme.light().copyWith(
      primary: Colors.black45, // rojo
      secondary: const Color(0xFF91D9D2), //azulito
      tertiary: const Color(0xffF2C1AE), // cafecito
    ),
    fontFamily: 'Inter',
    textTheme: const TextTheme(
      titleMedium: TextStyle(
          color: textColor, fontSize: 16, fontWeight: FontWeight.w500),
      titleLarge: TextStyle(
          color: textColor, fontSize: 20, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(
          color: textColor, fontSize: 13, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(
          color: textColor, fontSize: 16, fontWeight: FontWeight.normal),
      bodyLarge: TextStyle(
          color: textColor, fontSize: 20, fontWeight: FontWeight.normal),
      displayLarge: TextStyle(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
      displayMedium: TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: textColor),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: textColor),
      ),
      hintStyle: const TextStyle(color: Colors.black38),
    ),
    iconTheme: IconThemeData(color: Colors.grey.shade600),
    // appBarTheme: AppBarTheme(
    //   elevation: 0,
    //   backgroundColor: whiteColor,
    //   iconTheme: const IconThemeData(color: Colors.black),
    //   // color: Colors.black,
    //   actionsIconTheme: const IconThemeData(color: Colors.black),
    //   toolbarTextStyle: const TextTheme(
    //     titleLarge: TextStyle(color: textColor, fontSize: 20), //Letra blanca
    //   ).bodyMedium,
    //   titleTextStyle: const TextTheme(
    //     titleLarge: TextStyle(color: textColor, fontSize: 20), //Letra blanca
    //   ).titleLarge,
    // ),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: blackColor,
    canvasColor: blackColor,
    cardColor: blackColor,
    dividerTheme: const DividerThemeData(color: Colors.grey),

    // appBarTheme: const AppBarTheme (
    //   backgroundColor: primaryColor,
    //   foregroundColor: Colors.white,

    // ),
    primaryColor: primaryColor,
    hintColor: Colors.grey.shade200,
    indicatorColor: const Color(0xFF3E6F89),
    colorScheme: const ColorScheme.light().copyWith(
      primary: Colors.white, // rojo
      secondary: const Color(0xFF91D9D2), //azulito
      tertiary: const Color(0xffF2C1AE), // cafecito
    ),
    fontFamily: 'Inter',
    textTheme: const TextTheme(
      titleMedium: TextStyle(
          color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500),
      titleLarge: TextStyle(
          color: Colors.grey, fontSize: 20, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(
          color: Colors.grey, fontSize: 13, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(
          color: Colors.grey, fontSize: 16, fontWeight: FontWeight.normal),
      bodyLarge: TextStyle(
          color: Colors.grey, fontSize: 20, fontWeight: FontWeight.normal),
      displayLarge: TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
      displayMedium: TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: blackColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.white),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.white),
      ),
      hintStyle: const TextStyle(color: Colors.white38),
    ),
    iconTheme: IconThemeData(color: Colors.grey.shade600),
    // appBarTheme: AppBarTheme(
    //   elevation: 0,
    //   backgroundColor: whiteColor,
    //   iconTheme: const IconThemeData(color: Colors.black),
    //   // color: Colors.black,
    //   actionsIconTheme: const IconThemeData(color: Colors.black),
    //   toolbarTextStyle: const TextTheme(
    //     titleLarge: TextStyle(color: textColor, fontSize: 20), //Letra blanca
    //   ).bodyMedium,
    //   titleTextStyle: const TextTheme(
    //     titleLarge: TextStyle(color: textColor, fontSize: 20), //Letra blanca
    //   ).titleLarge,
    // ),
  );
}
