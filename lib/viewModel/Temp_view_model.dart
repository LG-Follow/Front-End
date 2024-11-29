// 임시저장 관련 기능
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/Temp.dart';

class TempViewModel extends ChangeNotifier {
  List<Drawing> _drawings = [
    Drawing(title: "Drawing 1"),
    Drawing(title: "Drawing 2"),
    Drawing(title: "Drawing 3"),
    Drawing(title: "Drawing 4")
  ];
  bool _isLoading = true;

  List<Drawing> get drawings => _drawings;
  bool get isLoading => _isLoading;

  final String? baseUrl = dotenv.env['BASE_URL'];

  Uri _buildUri(String endpoint) {
    return Uri.parse('$baseUrl$endpoint');
  }

  DrawingViewModel() {
    fetchDrawings();
  }


  Future<void> fetchDrawings() async {
    final url = _buildUri('endpoint 추가'); // 서버 엔드포인트 필요
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(url,
      headers: {
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': '69420',
      },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _drawings.addAll(data.map((json) => Drawing.fromJson(json)).toList());
      } else {
        throw Exception('Failed to load drawings');
      }
    } catch (e) {
      print("Failed to fetch drawings: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addDrawing(Drawing drawing) {
    _drawings.add(drawing);
    notifyListeners();
  }

  void removeDrawing(Drawing drawing) {
    _drawings.remove(drawing);
    notifyListeners();
  }
}
