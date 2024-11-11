import 'package:flutter/material.dart';
import '../model/Point.dart';

class DrawingPainter extends CustomPainter {
  final List<List<Point>> paths;
  final Listenable repaint;

  DrawingPainter(this.paths, {required this.repaint}) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..strokeCap = StrokeCap.round;

    for (var path in paths) {
      if (path.isNotEmpty) {
        for (int i = 0; i < path.length - 1; i++) {
          paint.color = path[i].color;
          paint.strokeWidth = path[i].strokeWidth;
          canvas.drawLine(path[i].offset, path[i + 1].offset, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) {
    return true; // 항상 리페인트하도록 설정
  }
}

