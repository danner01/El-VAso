import 'package:flutter/material.dart';

import '../../../../config/theme/my_themes.dart';

InputDecoration dropdownDecoration(BuildContext context) {
  final theme = Theme.of(context);
  return InputDecoration(
    
    // hintText: hintText,
    // hintStyle: 
    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
    filled: true,
    fillColor: theme.scaffoldBackgroundColor,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: theme.primaryColor.withOpacity(0.5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: theme.primaryColor),
    ),
  );
}
