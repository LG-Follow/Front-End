// 서버에서 데이터를 받아온 후, UI에 구현하기 위해 처리
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
  bool isFetching = false;

  List<CardItem> tempStorageItems = [
    CardItem(title: '24.11.25', imageUrl: 'assets/images/temp_image.png', isLocal: true),
  ];

  Future<void> fetchQuickSelectItems() async {
    if (isFetching) return; // 이미 데이터를 가져오는 중이면 중단
    isFetching = true;
    notifyListeners();

    try {
      final response = await http.get(_buildUri('/song/user/1'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        quickSelectItems = data.take(3).map((item) {
          return CardItem.fromJson(item);
        }).toList();
      } else {
        throw Exception('Failed to load quick select items');
      }
    } catch (e) {
      print('Error fetching quick select items: $e');
    } finally {
      isFetching = false;
      notifyListeners();
    }
  }
}



