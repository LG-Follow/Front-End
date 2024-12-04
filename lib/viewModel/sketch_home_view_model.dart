import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/sketch_home.dart';

class SketchViewModel extends ChangeNotifier {
  final String? baseUrl = dotenv.env['BASEURL'];

  Uri _buildUri(String endpoint) {
    return Uri.parse('$baseUrl$endpoint');
  }

  List<CardItem> quickSelectItems = [];
  bool _isFetching = false; // 중복 요청 방지 상태
  bool _hasFetched = false; // 요청 완료 여부 확인

  List<CardItem> tempStorageItems = [
    CardItem(title: '24.11.25', imageUrl: 'assets/images/temp_image.png', isLocal: true),
  ];

  bool get isFetching => _isFetching;

  Future<void> fetchQuickSelectItems() async {
    if (_isFetching || _hasFetched) return; // 이미 요청 중이거나 요청 완료 시 중단
    _isFetching = true;
    notifyListeners();

    try {
      final response = await http.get(_buildUri('/song/user/1'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        quickSelectItems = data.take(3).map((item) {
          return CardItem.fromJson(item);
        }).toList();
        _hasFetched = true; // 요청 완료 상태로 설정
      } else {
        throw Exception('Failed to load quick select items');
      }
    } catch (e) {
      print('Error fetching quick select items: $e');
    } finally {
      _isFetching = false; // 요청 종료
      notifyListeners();
    }
  }
}



