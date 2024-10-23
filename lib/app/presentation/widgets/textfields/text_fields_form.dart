import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'custom_input_decoration.dart';

// ignore: must_be_immutable
class TextFieldForm extends StatefulWidget {
  final TextEditingController controller;
  final TextStyle styleText;
  final String? hintText;
  final String? textValidation;
  final TextInputType textInputType;
  final bool password;

  Color colorIcon;
  final bool capitalization;
  final Function? onChanged;
  final FormFieldValidator<String>? validator;
  final bool colorNormal;
  // final Color backgroundColor;

  final double borderRadius;

  TextFieldForm({
    super.key,
    required this.controller,
    this.hintText,
    this.textValidation,
    required this.textInputType,
    this.password = false,
    this.capitalization = false,
    this.onChanged,
    this.colorNormal = true,
    this.validator,
    this.colorIcon = Colors.white,
    this.styleText = const TextStyle(
      fontSize: 17.0,
      // color: Colors.white,
    ),
    this.borderRadius = 16.0,
    // this.backgroundColor = const Color(0xffE4E7EE),
  });

  @override
  // ignore: library_private_types_in_public_api
  _TextFieldFormState createState() => _TextFieldFormState();
}

class _TextFieldFormState extends State<TextFieldForm> {
  bool hintPassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: widget.controller,
        style: widget.styleText,
        textCapitalization: (widget.capitalization)
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        keyboardType: widget.textInputType,
        obscureText: widget.password ? hintPassword : false,
        decoration: CustomInputDecoration.form(context),
        validator: (value) {
          if (widget.validator != null) {
            return widget.validator!(value);
          }
          return null;
        },
      ),
    );
  }

  buttonShowPassword() {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Icon(
          hintPassword
              ? FontAwesomeIcons.solidEye
              : FontAwesomeIcons.solidEyeSlash,
          size: 20,
          color: Colors.white,
        ),
      ),
      onTap: () {
        hintPassword = !hintPassword;
        setState(() {});
      },
    );
  }
}
