import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class TextFieldCustom extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;

  final String? textValidation;
  final TextInputType textInputType;
  final bool password;
  final IconData? icon;
  Color colorIcon;
  final bool capitalization;
  void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool colorNormal;
  final bool readOnly;
  void Function()? onTap;
  final Widget? prefixIcon;

  TextFieldCustom({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.textValidation,
    required this.textInputType,
    this.password = false,
    this.icon,
    this.capitalization = false,
    this.onChanged,
    this.colorNormal = true,
    this.validator,
    this.colorIcon = Colors.grey,
    this.readOnly = false,
    this.onTap,
    this.prefixIcon,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TextFieldCustomState createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  bool hintPassword = true;
  late Color textColor;
  Color iconColor = Colors.grey;

  late IconData? iconData;

  @override
  void initState() {
    super.initState();
    iconData = widget.icon;
  }

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
        suffixIcon = InkWell(
          borderRadius: BorderRadius.circular(30),
          child: Icon(
            widget.icon,
            color: widget.colorIcon,
            size: 20,
          ),
          onTap: () {
            if (widget.controller != null) {
              widget.controller!.clear();
            }
          },
        );
      } else {
        suffixIcon = Icon(iconData, size: 20, color: iconColor);
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              child: (widget.labelText != null)
                  ? Text(
                      widget.labelText!,
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w300,
                          fontSize: 14),
                    )
                  : null,
            ),
          ],
        ),
        TextFormField(
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          controller: widget.controller,
          style: TextStyle(fontSize: 17, color: textColor),
          textCapitalization: (widget.capitalization)
              ? TextCapitalization.sentences
              : TextCapitalization.none,
          keyboardType: widget.textInputType,
          obscureText: widget.password ? hintPassword : false,
          decoration: InputDecoration(
            label: null,
            filled: true,
            // fillColor: widget.colorNormal
            //     ? Theme.of(context).colorScheme.surface.withAlpha(180)
            //     : Colors.grey.withOpacity(0.3),
            hoverColor: Theme.of(context).canvasColor.withOpacity(0.2),
            focusColor: Colors.green,
            hintText: widget.hintText,
            hintStyle: TextStyle(
                color: textColor.withOpacity(0.5), fontWeight: FontWeight.w300),
            suffixIcon: suffixIcon,
            prefixIcon: widget.prefixIcon,
            // suffixIcon: widget.password
            //     ? buttonShowPassword()
            //     : widget.icon != null
            //         ? Icon(widget.icon, size: 20, color: widget.colorIcon)
            //         : null,
            // border:
            //     OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(10.0),
            //   borderSide:
            //       BorderSide(color: theme.primaryColor.withOpacity(0.5)),
            // ),
          ),
          onChanged: widget.onChanged,
          validator: (value) {
            if (widget.validator != null) {
              final valid = widget.validator!(value);
              if (valid == null) {
                setState(() {
                  iconColor = theme.primaryColor;
                  iconData = widget.icon;
                });
              } else {
                setState(() {
                  iconColor = Colors.red;
                  iconData = Icons.warning;
                });
              }
              return valid;
            }
            return null;
          },
        ),
      ],
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
