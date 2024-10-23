import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../config/theme/my_themes.dart';

class VerificationCodeInput extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onCompleted;

  const VerificationCodeInput({
    super.key,
    required this.controller,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      backgroundColor:
          (Theme.of(context).scaffoldBackgroundColor.value == whiteColor.value)
              ? Colors.white
              : Colors.grey[850],
      appContext: context,
      length: 6,
      controller: controller,
      autoFocus: true,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedFillColor: Colors.white,
        activeColor: Colors.blue,
        inactiveColor: Colors.grey,
        selectedColor: Colors.blue,
      ),
      cursorColor:
          (Theme.of(context).scaffoldBackgroundColor.value == whiteColor.value)
              ? Colors.black
              : textColor,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        // Do something when the value changes
      },
      onCompleted: onCompleted,
      beforeTextPaste: (text) {
        return false; // Disable pasting
      },
    );
  }
}
