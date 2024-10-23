import 'package:flutter/material.dart';

class CustomCircularProgress extends StatelessWidget {
  final Color? color;
  final double height;
  final double width;

  const CustomCircularProgress(
      {super.key, this.height = 100, this.width = 100, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: CircularProgressIndicator(
          color: color ?? Theme.of(context).primaryColor,
          strokeWidth: 4,
        ),
      ),
    );
  }
}
