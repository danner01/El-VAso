import 'package:flutter/material.dart';

import '../../../config/theme/app_constans.dart';

class CustomInputDecoration {
  static form(BuildContext context) {
    final theme = Theme.of(context);
    return InputDecoration(
      filled: true,
      fillColor: theme.inputDecorationTheme.fillColor,
      hoverColor: Theme.of(context).primaryColor.withOpacity(0.2),
      focusColor: Colors.green,
      // hintText: 'Pais',
      hintStyle: theme.inputDecorationTheme.hintStyle,
      border: OutlineInputBorder(
        borderRadius: AppConstants.borderRadius,
      ),
      contentPadding: const EdgeInsets.only(left: 15),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppConstants.borderRadius,
        borderSide: const BorderSide(color: Colors.grey),
      ),
    );
  }

  static formDisabled(BuildContext context) {
    final theme = Theme.of(context);
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade300,
      hoverColor: Theme.of(context).primaryColor.withOpacity(0.2),
      focusColor: Colors.green,
      // hintText: 'Pais',
      hintStyle: theme.inputDecorationTheme.hintStyle,
      border: OutlineInputBorder(
        borderRadius: AppConstants.borderRadius,
      ),
      contentPadding: const EdgeInsets.only(left: 15),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppConstants.borderRadius,
        borderSide: const BorderSide(color: Colors.grey),
      ),
    );
  }
}
