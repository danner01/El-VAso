import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class TextFieldCustom2 extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;

  final String? textValidation;
  final TextInputType textInputType;
  final bool password;
  final IconData? icon;
  Color colorIcon;
  final TextCapitalization textCapitalization;
  void Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final bool colorNormal;
  final bool readOnly;
  void Function()? onTap;
  final bool allUpperCase;
  List<TextInputFormatter>? inputFormatters;

  TextFieldCustom2({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.textValidation,
    required this.textInputType,
    this.password = false,
    this.icon,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.colorNormal = true,
    this.validator,
    this.colorIcon = Colors.grey,
    this.readOnly = false,
    this.onTap,
    this.allUpperCase = false,
    this.inputFormatters,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TextFieldCustom2State createState() => _TextFieldCustom2State();
}

class _TextFieldCustom2State extends State<TextFieldCustom2> {
  bool hintPassword = true;
  late Color textColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    textColor = Theme.of(context).textTheme.bodyMedium!.color!;
    if (widget.colorIcon == Colors.black) {
      widget.colorIcon = textColor;
    }

    Widget? suffixIcon;
    if (widget.password) {
      suffixIcon = buttonShowPassword();
    } else if (widget.icon != null) {
      if (widget.icon == Icons.close) {
        suffixIcon = IconButton(
          icon: Icon(widget.icon, color: widget.colorIcon),
          onPressed: () {
            if (widget.controller != null) {
              widget.controller!.clear();
            }
          },
        );
      } else {
        suffixIcon = Icon(widget.icon, size: 20, color: widget.colorIcon);
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        onTap: widget.onTap,
        readOnly: widget.readOnly,
        controller: widget.controller,
        style: TextStyle(fontSize: 17, color: textColor),
        textCapitalization: widget.textCapitalization,
        keyboardType: widget.textInputType,
        obscureText: widget.password ? hintPassword : false,
        decoration: InputDecoration(
          labelText: widget.labelText ?? '',
          labelStyle: TextStyle(color: theme.primaryColor),
          // label: widget.labelText != null
          //     ? Text(
          //         widget.labelText!,
          //         style: TextStyle(color: theme.primaryColor),
          //       )
          //     : null,
          filled: true,
          fillColor: widget.colorNormal
              ? Theme.of(context).colorScheme.surface.withAlpha(180)
              : Colors.grey.withOpacity(0.3),
          hoverColor: Theme.of(context).primaryColor.withOpacity(0.2),
          focusColor: Colors.green,
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: textColor.withOpacity(0.5), fontWeight: FontWeight.w300),
          suffixIcon: suffixIcon,
          // suffixIcon: widget.password
          //     ? buttonShowPassword()
          //     : widget.icon != null
          //         ? Icon(widget.icon, size: 20, color: widget.colorIcon)
          //         : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: theme.primaryColor.withOpacity(0.5)),
          ),
        ),
        onChanged: widget.onChanged,
        validator: (value) =>
            widget.validator == null ? null : widget.validator!(value),
      ),
    );
  }

  buttonShowPassword() {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Icon(
          hintPassword ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
          size: 20,
          color: Colors.grey,
        ),
      ),
      onTap: () {
        hintPassword = !hintPassword;
        setState(() {});
      },
    );
  }
}

class UppercaseInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
