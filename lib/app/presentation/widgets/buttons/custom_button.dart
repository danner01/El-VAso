import 'package:flutter/material.dart';

import '../../../config/theme/my_themes.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Widget? icon;
  final bool isLeftIcon;
  final VoidCallback? onPressed;
  final double height;
  final double width;
  final double paddingH;
  final double paddingV;
  final Color? color;
  final double elevation;
  final double borderRadius;
  final bool withBorderColor;
  final TextStyle textStyle;
  final bool isLoading;
  final String? loadingText;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 45,
    this.paddingH = 0,
    this.paddingV = 0,
    this.color,
    this.width = double.infinity,
    this.borderRadius = 10,
    this.elevation = 1,
    this.withBorderColor = false,
    this.isLoading = false,
    this.icon,
    this.textStyle = const TextStyle(color: Colors.white),
    this.loadingText,
    this.isLeftIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
        child: MaterialButton(
          // textColor: Colors.white,

          disabledColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
                color:theme.primaryColor),
          ),
          height: height,
          minWidth: size.width,
          color: color ?? Theme.of(context).primaryColor,
          elevation: elevation,
          padding: const EdgeInsets.all(7.0),
          onPressed: onPressed,
          child: isLoading ? _buildLoadingInfo() : _buildNormalInfo(),
        ),
      ),
    );
  }

  Widget _buildLoadingInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null)
          Padding(padding: const EdgeInsets.only(right: 10), child: icon),
        Text(loadingText!, style: textStyle),
        const SizedBox(width: 10),
        SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(color: textStyle.color),
        ),
      ],
    );
  }

  Widget _buildNormalInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: isLeftIcon
          ? [
              if (icon != null)
                Padding(padding: const EdgeInsets.only(right: 10), child: icon),
              Text(text, style: textStyle),
            ]
          : [
              Text(text, style: textStyle),
              if (icon != null)
                Padding(padding: const EdgeInsets.only(left: 5), child: icon),
            ],
    );
  }
}
