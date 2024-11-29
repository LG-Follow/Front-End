// 가전 추가 선택 페이지
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModel/product_view_model.dart';
import '../model/product.dart';
import '../view/qr_scan_view.dart';

class ProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProductViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '추가할 제품을 선택해 주세요.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            // 검색 입력 필드
            TextField(
              onChanged: (query) => viewModel.updateSearchQuery(query),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: '제품명 또는 모델명 검색',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.black),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            // 하나의 카드 내에서 필터된 제품 목록 표시
            Expanded(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.black, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: viewModel.filteredProducts.map((product) {
                      return Column(
                        children: [
                          ListTile(
                            leading: Image.asset(
                              product.iconPath,
                              width: 40,
                              height: 40,
                            ),
                            title: Text(
                              product.name,
                              style: TextStyle(fontSize: 16),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => QRScanView()),
                              );
                              // 제품 선택 시 추가 동작
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50.0), // 양쪽 여백 추가
                            child: Container(
                              height: 1,
                              color: Colors.grey[300], // 구분선 색상 설정
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Image.asset(
                'assets/images/lg_follow_logo.png',
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}