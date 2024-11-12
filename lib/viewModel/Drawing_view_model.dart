import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../model/Point.dart';
import '../model/drawing_painter.dart';

class DrawingViewModel with ChangeNotifier {
  List<List<Point>> _paths = [];
  bool _isDrawing = false;
  Color _currentColor = Colors.black;
  double _currentStrokeWidth = 2.0;

  List<List<Point>> get paths => _paths;
  bool get isDrawing => _isDrawing;
  Color get currentColor => _currentColor;
  double get currentStrokeWidth => _currentStrokeWidth;

  final String? baseUrl = dotenv.env['BASE_URL'];

  // Base URL과 endpoint를 조합하여 URL 생성
  Uri _buildUri(String endpoint) {
    return Uri.parse('$baseUrl$endpoint');
  }

  void startDrawing() {
    _isDrawing = true;
    _paths.add([]); // Start a new path
    notifyListeners();
  }

  void stopDrawing() {
    _isDrawing = false;
    notifyListeners();
  }

  void addPoint(Offset offset) {
    if (_isDrawing && _paths.isNotEmpty) {
      _paths.last.add(Point(offset, _currentColor, _currentStrokeWidth));
      notifyListeners(); // Update UI in real-time
    }
  }

  void clearDrawing() {
    _paths.clear();
    notifyListeners();
  }

  void setColor(Color color) {
    _currentColor = color;
    notifyListeners();
  }

  void setStrokeWidth(double width) {
    _currentStrokeWidth = width;
    notifyListeners();
  }

  Future<void> sendDrawing() async {
    try {
      final pictureRecorder = ui.PictureRecorder();
      final canvas = Canvas(pictureRecorder);
      final size = Size(400, 600); // Define canvas size

      final painter = DrawingPainter(_paths, repaint: this);
      painter.paint(canvas, size);

      final picture = pictureRecorder.endRecording();
      final image = await picture.toImage(size.width.toInt(), size.height.toInt());
      print(image);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      print(byteData);
      final base64Image = base64Encode(byteData!.buffer.asUint8List());
      print(base64Image);

      final url = _buildUri('/image/upload');
      if (url != null) {
        print(base64Image);

        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "user_id": 1,
            "image": base64Image,
          }),
        );
        print(response.statusCode);

        if (response.statusCode == 200) {
          print("Drawing sent successfully!");
        } else {
          print("Failed to send drawing: ${response.statusCode}");
        }
      }
    } catch (e) {
      print("Error sending drawing: $e");
    }
  }
}
