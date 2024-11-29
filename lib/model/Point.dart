// 각 점의 정보를 캡슐화하고, 이를 JSON 형식으로 변환할 수 있도록 구현합니다.
import 'package:flutter/material.dart';

class Point {
  final Offset offset;
  final Color color;
  final double strokeWidth;

  Point(this.offset, this.color, this.strokeWidth);

  Map<String, dynamic> toJson() => {
    'x': offset.dx,
    'y': offset.dy,
    'color': color.value.toRadixString(16),  // 색상을 16진수 문자열로 변환
    'strokeWidth': strokeWidth,
  };
}
