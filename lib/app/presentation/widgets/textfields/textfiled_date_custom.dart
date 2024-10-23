import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class TextFieldPhoneCustom extends StatefulWidget {
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
///////////////////////////////////

  TextFieldPhoneCustom({
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
  });

  @override
  // ignore: library_private_types_in_public_api
  _TextFieldPhoneCustomState createState() => _TextFieldPhoneCustomState();
}

class _TextFieldPhoneCustomState extends State<TextFieldPhoneCustom> {
  bool hintPassword = true;
  late Color textColor;
  Color iconColor = Colors.grey;

  late IconData? iconData;


  String selectedPrefix = '+1'; // Prefijo seleccionado por defecto
  final List<Map<String, String>> countries = [
    {'flag': '🇦🇺', 'code': '+61', 'name': 'Australia'},
    {'flag': '🇦🇹', 'code': '+43', 'name': 'Austria'},
    {'flag': '🇧🇪', 'code': '+32', 'name': 'Belgium'},
    {'flag': '🇧🇷', 'code': '+55', 'name': 'Brazil'},
    {'flag': '🇨🇦', 'code': '+1', 'name': 'Canada'},
    {'flag': '🇨🇳', 'code': '+86', 'name': 'China'},
    {'flag': '🇨🇴', 'code': '+57', 'name': 'Colombia'},
    {'flag': '🇨🇷', 'code': '+506', 'name': 'Costa Rica'},
    {'flag': '🇨🇺', 'code': '+53', 'name': 'Cuba'},
    {'flag': '🇪🇨', 'code': '+593', 'name': 'Ecuador'},
    {'flag': '🇪🇪', 'code': '+372', 'name': 'Estonia'},
    {'flag': '🇪🇸', 'code': '+34', 'name': 'Spain'},
    {'flag': '🇫🇷', 'code': '+33', 'name': 'France'},
    {'flag': '🇩🇪', 'code': '+49', 'name': 'Germany'},
    {'flag': '🇬🇧', 'code': '+44', 'name': 'United Kingdom'},
    {'flag': '🇮🇳', 'code': '+91', 'name': 'India'},
    {'flag': '🇮🇩', 'code': '+62', 'name': 'Indonesia'},
    {'flag': '🇮🇹', 'code': '+39', 'name': 'Italy'},
    {'flag': '🇯🇵', 'code': '+81', 'name': 'Japan'},
    {'flag': '🇲🇽', 'code': '+52', 'name': 'Mexico'},
    {'flag': '🇲🇦', 'code': '+212', 'name': 'Morocco'},
    {'flag': '🇳🇱', 'code': '+31', 'name': 'Netherlands'},
    {'flag': '🇳🇿', 'code': '+64', 'name': 'New Zealand'},
    {'flag': '🇵🇪', 'code': '+51', 'name': 'Peru'},
    {'flag': '🇵🇭', 'code': '+63', 'name': 'Philippines'},
    {'flag': '🇵🇹', 'code': '+351', 'name': 'Portugal'},
    {'flag': '🇷🇺', 'code': '+7', 'name': 'Russia'},
    {'flag': '🇸🇦', 'code': '+966', 'name': 'Saudi Arabia'},
    {'flag': '🇸🇬', 'code': '+65', 'name': 'Singapore'},
    {'flag': '🇱🇸', 'code': '+266', 'name': 'Lesotho'},
    {'flag': '🇲🇾', 'code': '+60', 'name': 'Malaysia'},
    {'flag': '🇲🇨', 'code': '+377', 'name': 'Monaco'},
    {'flag': '🇲🇩', 'code': '+373', 'name': 'Moldova'},
    {'flag': '🇲🇲', 'code': '+95', 'name': 'Myanmar'},
    {'flag': '🇳🇬', 'code': '+234', 'name': 'Nigeria'},
    {'flag': '🇳🇴', 'code': '+47', 'name': 'Norway'},
    {'flag': '🇵🇱', 'code': '+48', 'name': 'Poland'},
    {'flag': '🇲🇲', 'code': '+95', 'name': 'Myanmar'},
    {'flag': '🇸🇪', 'code': '+46', 'name': 'Sweden'},
    {'flag': '🇺🇸', 'code': '+1', 'name': 'United States'},
    {'flag': '🇺🇾', 'code': '+598', 'name': 'Uruguay'},
    {'flag': '🇺🇦', 'code': '+380', 'name': 'Ukraine'},
    {'flag': '🇿🇦', 'code': '+27', 'name': 'South Africa'},
    {'flag': '🇻🇳', 'code': '+84', 'name': 'Vietnam'},
    {'flag': '🇿🇲', 'code': '+260', 'name': 'Zambia'},
  ];
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
                      style: TextStyle(color: theme.canvasColor, fontSize: 14),
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
            fillColor: widget.colorNormal
                ? Theme.of(context).colorScheme.surface.withAlpha(180)
                : Colors.grey.withOpacity(0.3),
            hoverColor: Theme.of(context).canvasColor.withOpacity(0.2),
            focusColor: Colors.green,
            hintText: widget.hintText,
            hintStyle: TextStyle(
                color: textColor.withOpacity(0.5), fontWeight: FontWeight.w300),
            suffixIcon: suffixIcon,
            prefixIcon: DropdownButton<Map<String, String>>(
      value:
          countries.firstWhere((country) => country['code'] == selectedPrefix),
          
      items: countries.map((Map<String, String> country) {
        return DropdownMenuItem<Map<String, String>>(
          value: country,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               const SizedBox(width: 8),
              Text(country['flag']!),
              const SizedBox(width: 8),
              Text(country['code']!),
            ],
          ),
        );
      }).toList(),
      onChanged: (Map<String, String>? newValue) {
        setState(() {
          selectedPrefix = newValue!['code']!;
          // widget.controller?.text = '($selectedPrefix) ';
        });
      },
      underline: const SizedBox.shrink(), // Quita la línea subrayada
    ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  BorderSide(color: theme.primaryColor.withOpacity(0.5)),
            ),
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
        // setState(() {});
      },
    );
  }
}
