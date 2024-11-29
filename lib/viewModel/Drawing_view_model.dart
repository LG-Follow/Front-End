// 그림 그리는 기능과 서버로 전송하는 기능 + 파일첨부 기능 원하는 사진 전송
// 그림 관련 상태 관리, 이미지 업로드, UI 업데이트
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../model/Point.dart';
import '../model/drawing_painter.dart';

class DrawingViewModel with ChangeNotifier {
  List<List<Point>> _paths = [];
  List<File> _uploadedImages = []; // 업로드된 사진 목록
  bool _isDrawing = false;
  Color _currentColor = Colors.black;
  double _currentStrokeWidth = 2.0;

  List<List<Point>> get paths => _paths;
  List<File> get uploadedImages => _uploadedImages; // 업로드된 사진 목록 Getter
  bool get isDrawing => _isDrawing;
  Color get currentColor => _currentColor;
  double get currentStrokeWidth => _currentStrokeWidth;

  final String? baseUrl = dotenv.env['BASEURL'];

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
    _uploadedImages.clear(); // 업로드된 사진도 초기화
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

  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        _uploadedImages.add(imageFile); // 업로드된 이미지를 목록에 추가
        notifyListeners();
      }
    } catch (e) {
      print("Error picking image: $e");
    }
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
      print(url);
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
