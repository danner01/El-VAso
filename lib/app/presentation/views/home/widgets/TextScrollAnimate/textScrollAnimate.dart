import 'package:flutter/material.dart';

class ScrollingText extends StatefulWidget {
  final String text;

  const ScrollingText({Key? key, required this.text}) : super(key: key);

  @override
  _ScrollingTextState createState() => _ScrollingTextState();
}

class _ScrollingTextState extends State<ScrollingText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50, // Altura del contenedor
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Row(
            children: [
              // Ajusta el tamaño del espacio en blanco para un scroll continuo
              SizedBox(width: MediaQuery.of(context).size.width * _animation.value),
              Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              // Espacio adicional para que el texto se repita
              SizedBox(width: 20), // Espacio entre el texto y el final
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
