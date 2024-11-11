import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModel/sketch_home_view_model.dart';
import '../model/sketch_home.dart';
import '../view/song_home_view.dart';
import '../view/Drawing_view.dart';

class SketchHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SketchViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset('assets/images/sound_sketch_logo.png', height: 50, width: 150),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTextButton('잠잘 때'),
                  SizedBox(width: 8),
                  _buildTextButton('에너지 충전'),
                  SizedBox(width: 8),
                  _buildTextButton('행복한 기분'),
                  SizedBox(width: 8),
                  _buildTextButton('운동'),
                ],
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SongHomeView()),
                );
              },
              child: Row(
                children: [
                  Text(
                    '빠른 선곡',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
                ],
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: viewModel.quickSelectItems.map((item) => _buildCard(item)).toList(),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  '임시 저장',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: viewModel.tempStorageItems.map((item) => Expanded(child: _buildCard(item))).toList(),
            )],
            ),
          ),
        ],
      ),
      bottomSheet: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! < -10) { // 위로 드래그 시 페이지 로드
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return FractionallySizedBox(
                  heightFactor: 0.9,
                  child: DrawingView(),
                );
              },
            );
          }
        },
        child: Container(
          height: 50, // 드래그 핸들 높이
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow:[
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, -3),
              ),]
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/finger.png',
                  height: 40,
                  width: 40,
                ),
                SizedBox(width: 8),
                Text(
                  "위로 드래그하여 시작하기", // 드래그 핸들에 설명 텍스트 추가
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: '디스커버',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: '리포트',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: '메뉴',
          ),
        ],
      ),
    );
  }

  // 텍스트 버튼 생성 함수
  Widget _buildTextButton(String label) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: Colors.black, width: 1),
      ),
      child: Text(label, style: TextStyle(color: Colors.black)),
    );
  }

  // 이미지 카드 생성 함수
  Widget _buildCard(CardItem item) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.black, width: 1),
      ),
      elevation: 4,
      child: Column(
        children: [
          Image.asset(item.imagePath, width: 100, height: 100, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
