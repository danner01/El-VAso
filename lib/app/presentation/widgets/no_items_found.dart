import 'package:flutter/material.dart';

class NoItemsFoundWidget extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? iconColor;
  const NoItemsFoundWidget(this.text, {super.key, this.icon, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ShakingIcon(icon: icon!, iconColor: iconColor),
            ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ShakingIcon extends StatefulWidget {
  final IconData icon;
  final Color? iconColor;

  const ShakingIcon({super.key, required this.icon, this.iconColor});

  @override
  // ignore: library_private_types_in_public_api
  _ShakingIconState createState() => _ShakingIconState();
}

class _ShakingIconState extends State<ShakingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: -0.2, end: 0.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _animation.value,
          child: Icon(
            widget.icon,
            size: 50,
            color: widget.iconColor ?? Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }
}
