import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
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

  Uri _buildUri(String endpoint) {
    return Uri.parse('$baseUrl$endpoint');
  }

  void startDrawing() {
    _isDrawing = true;
    _paths.add([]);
    notifyListeners();
  }

  void stopDrawing() {
    _isDrawing = false;
    notifyListeners();
  }

  void addPoint(Offset offset) {
    if (_isDrawing && _paths.isNotEmpty) {
      _paths.last.add(Point(offset, _currentColor, _currentStrokeWidth));
      notifyListeners();
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
      final size = Size(400, 600);

      final painter = DrawingPainter(_paths, repaint: this);
      painter.paint(canvas, size);

      final picture = pictureRecorder.endRecording();
      final image = await picture.toImage(size.width.toInt(), size.height.toInt());
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final url = _buildUri('/image/upload');
      final request = http.MultipartRequest('POST', url)
        ..fields['user_id'] = '1' // user_id 필드 추가
        ..files.add(
          http.MultipartFile.fromBytes(
            'image',
            pngBytes,
            filename: 'drawing.png',
            contentType: MediaType('image', 'png'),
          ),
        );

      final response = await request.send();

      if (response.statusCode == 200) {
        print("Drawing sent successfully!");
      } else {
        print("Failed to send drawing: ${response.statusCode}");
      }
    } catch (e) {
      print("Error sending drawing: $e");
    }
  }
}
