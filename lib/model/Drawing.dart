// 그린 그림 데이터를 JSON 형태로 직렬화하거나 Base64 문자열로 변환하여 서버로 전송하는 역할을 합니다.
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
