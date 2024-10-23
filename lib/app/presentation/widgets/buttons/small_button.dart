import 'package:flutter/material.dart';

enum SmallButtonVariant {
  outlined,
  contained,
}

class SmallButton extends StatelessWidget {
  final bool disabled;
  final String text;
  final VoidCallback? onPressed;
  final SmallButtonVariant smallButtonVariant;
  final bool textColorBlack;
  final Size size;
  final double borderRadius;
  final bool isLoading;

  const SmallButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.smallButtonVariant = SmallButtonVariant.contained,
    this.borderRadius = 10,
    this.size = const Size(100, 40),
    this.textColorBlack = false,
    this.isLoading = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        minimumSize: size,
        backgroundColor: disabled
            ? Colors.grey
            : smallButtonVariant == SmallButtonVariant.contained
                ? theme.primaryColor
                : theme.scaffoldBackgroundColor,
        side: BorderSide(color: theme.primaryColor, width: 1),
      ),
      onPressed: disabled ? null : onPressed,
      child: isLoading
          ? SizedBox(
              width: size.height * 0.6,
              height: size.height * 0.6,
              child: const CircularProgressIndicator(color: Colors.white),
            )
          : Text(
              text,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: smallButtonVariant == SmallButtonVariant.contained
                    ? Colors.white
                    : textColorBlack
                        ? Colors.black
                        : theme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }
}
