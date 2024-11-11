// model/drawing_model.dart
import 'dart:convert';

class DrawingModel {
  final List<Map<String, double>> points;

  DrawingModel(this.points);

  // points 리스트를 base64 문자열로 변환
  String toBase64() {
    final jsonPoints = jsonEncode(points);
    final bytes = utf8.encode(jsonPoints);
    return base64Encode(bytes);
  }
}
