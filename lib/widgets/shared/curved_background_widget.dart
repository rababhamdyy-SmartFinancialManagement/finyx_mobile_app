import 'package:flutter/material.dart';

class CurvedBackgroundPainter extends CustomPainter {
  final BuildContext context;

  CurvedBackgroundPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 100,
    );
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    path.close();

    double circleRadius = isLandscape ? size.width * 0.44 : size.width * 0.6;

    Paint circle1Paint =
        Paint()
          ..shader = RadialGradient(
            colors: [
              const Color(0xFF3E0555),
              const Color(0xFF3E0555),
              const Color(0xFF5E2D88),
              const Color(0xFF7d469f).withValues(alpha: 0.8),
              const Color.fromARGB(255, 222, 190, 244).withValues(alpha: 0.7),
              Colors.white.withValues(alpha: 0.0),
            ],
            radius: 1.0,
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.7, size.height * -0.1),
              radius: circleRadius,
            ),
          );

    canvas.drawCircle(
      Offset(size.width * 0.7, size.height * 0.1),
      circleRadius,
      circle1Paint,
    );

    Paint circle2Paint =
        Paint()
          ..shader = RadialGradient(
            colors: [
              Colors.white,
              const Color(0xFF7d469f).withValues(alpha: 0.1),
              const Color(0xFF7d469f).withValues(alpha: 0.2),
              const Color(0xFF3E0555).withValues(alpha: 0.4),
            ],
            radius: 1.0,
            center: Alignment.bottomRight, 
            stops: [0.0, 0.5, 0.8, 1.0], 
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.3, size.height * 0.2),
              radius: circleRadius,
            ),
          );

    canvas.drawCircle(
      Offset(size.width * 0.3, size.height * 0.2),
      circleRadius,
      circle2Paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
