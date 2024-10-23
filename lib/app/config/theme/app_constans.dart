import 'package:flutter/material.dart';

class AppConstants {
  static BorderRadius borderRadiusAuth = BorderRadius.circular(8.0);
  static BorderRadius borderRadius = BorderRadius.circular(8.0);
  static List<BoxShadow> boxShadow = [
    const BoxShadow(
        blurRadius: 20,
        color: Colors.black45,
        spreadRadius: 1,
        offset: Offset(0.5, -0.5))
  ];

  static RoundedRectangleBorder buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  );
}
