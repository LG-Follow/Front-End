// 가전 추가 기능
import 'package:flutter/material.dart';
import '../model/product.dart';

class ProductViewModel extends ChangeNotifier {
  List<Product> _products = [
    Product(name: '세탁기', iconPath: 'assets/images/washing.png'),
    Product(name: '건조기', iconPath: 'assets/images/dryer.png'),
    Product(name: '냉장고', iconPath: 'assets/images/ref.png'),
    Product(name: '로봇 청소기', iconPath: 'assets/images/robot.png'),
    Product(name: '스피커', iconPath: 'assets/images/speaker.png'),
  ];

  String _searchQuery = '';

  // 필터된 제품 목록을 반환
  List<Product> get filteredProducts {
    return _products.where((product) {
      return product.name.contains(_searchQuery);
    }).toList();
  }

  // 검색어 업데이트
  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
