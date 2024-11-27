// sketch_view_model.dart
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/sketch_home.dart';

class SketchViewModel extends ChangeNotifier {
  final String? baseUrl = dotenv.env['BASEURL'];

  Uri _buildUri(String endpoint) {
    return Uri.parse('$baseUrl$endpoint');
  }

  List<CardItem> quickSelectItems = [
    CardItem(title: '24.11.01', imagePath: 'assets/images/Follow.png'),
    CardItem(title: '24.11.02', imagePath: 'assets/images/lg_follow_logo.png'),
    CardItem(title: '24.11.03', imagePath: 'assets/images/sound_sketch_logo.png'),
  ];

  List<CardItem> tempStorageItems = [
    CardItem(title: '24.11.25', imagePath: 'assets/images/temp_image.png'),
  ];

  void onCardTap(CardItem item) {
    // 카드 클릭 시 추가 동작 처리
  }
}
