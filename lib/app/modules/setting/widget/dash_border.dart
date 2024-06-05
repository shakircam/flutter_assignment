import 'dart:ui';

import 'package:flutter/material.dart';

class DashedBorder extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red // Set the color of the border
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const double dashWidth = 1.0;
    const double dashSpace = 3.0;
    double startX = 0.0;

    final path = Path();
    path.addOval(Rect.fromLTWH(0, 0, size.width, size.height));

    Path dashPath = Path();
    final PathMetric pathMetric = path.computeMetrics().first;
    while (startX < pathMetric.length) {
      dashPath.addPath(
        pathMetric.extractPath(startX, startX + dashWidth),
        Offset.zero,
      );
      startX += dashWidth + dashSpace;
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
