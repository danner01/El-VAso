import 'package:flutter/material.dart';

import '../../../config/theme/app_constans.dart';

class NormButton extends StatelessWidget {
  const NormButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: AppConstants.buttonShape,
      height: 45,
      minWidth: 70,
      color: Colors.white,
      child: const Text(
        'NORM',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      onPressed: () {},
    );
  }
}
