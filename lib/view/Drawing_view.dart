// 사용자가 그림 그리는, 파일을 첨부하는 페이지입니다.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModel/Drawing_view_model.dart';
import '../model/drawing_painter.dart';

class DrawingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DrawingViewModel>(context);

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: viewModel.clearDrawing,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                  child: Text('삭제하기', style: TextStyle(color: Colors.black)),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: viewModel.sendDrawing,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text('전송하기', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.upload_file, color: Colors.black),
                  onPressed: viewModel.pickImage, // 사진첩 접근
                ),
              ],
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.brush, color: Colors.black),
                    onPressed: () => viewModel.setStrokeWidth(2.0),
                  ),
                  IconButton(
                    icon: Icon(Icons.create, color: Colors.black),
                    onPressed: () => viewModel.setStrokeWidth(5.0),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.black),
                    onPressed: () => viewModel.setStrokeWidth(8.0),
                  ),
                  SizedBox(width: 16),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildColorButton(Colors.red, viewModel),
                      _buildColorButton(Colors.yellow, viewModel),
                      _buildColorButton(Colors.blue, viewModel),
                      _buildColorButton(Colors.green, viewModel),
                      _buildColorButton(Colors.purple, viewModel),
                      _buildColorButton(Colors.orange, viewModel),
                      _buildColorButton(Colors.cyan, viewModel),
                      _buildColorButton(Colors.black, viewModel),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onPanStart: (details) {
                          viewModel.startDrawing();
                          viewModel.addPoint(details.localPosition);
                        },
                        onPanUpdate: (details) {
                          viewModel.addPoint(details.localPosition);
                        },
                        onPanEnd: (_) {
                          viewModel.stopDrawing();
                        },
                        child: CustomPaint(
                          painter: DrawingPainter(viewModel.paths, repaint: viewModel),
                          child: Container(),
                        ),
                      ),
                    ),
                    if (viewModel.uploadedImages.isNotEmpty)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: viewModel.uploadedImages.map((image) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0), // 카드의 둥근 모서리와 일치하도록 설정
                                child: SizedBox(
                                  width: 100, // 적절한 크기 지정
                                  height: 100,
                                  child: Image.file(
                                    image,
                                    fit: BoxFit.cover, // 이미지가 카드의 크기를 꽉 채우도록 설정
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
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

  Widget _buildColorButton(Color color, DrawingViewModel viewModel) {
    return GestureDetector(
      onTap: () => viewModel.setColor(color),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 1),
        ),
      ),
    );
  }
}
