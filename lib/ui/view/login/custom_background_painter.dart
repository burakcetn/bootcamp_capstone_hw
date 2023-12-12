import 'package:flutter/material.dart';

class CustomBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white;

    var firstRef = Offset(size.width / 8, size.height - 100);
    var firstEnd = Offset(size.width / 2, size.height - 100);

    var secondRef = Offset(size.width * 7 / 8, size.height - 100);
    var secondEnd = Offset(size.width, size.height - 200);

    var path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(firstRef.dx, firstRef.dy, firstEnd.dx, firstEnd.dy)
      ..quadraticBezierTo(
          secondRef.dx, secondRef.dy, secondEnd.dx, secondEnd.dy)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
