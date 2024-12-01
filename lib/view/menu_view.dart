// 메뉴 페이지. 주요 기능인 사운드 스케치로 이동하기 위한 페이지
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModel/menu_view_model.dart';
import '../model/menu.dart';
import '../view/sketch_home_view.dart';
import '../view/Sound.dart';

class MenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MenuViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Flexible(
          child: FittedBox(
            fit: BoxFit.contain,
            child: Image.asset(
              'assets/images/lg_follow_logo.png',
              height: 70,
              width: 170,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '김민근 님',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width - 8.0, // 8px 만큼 줄임
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text('멤버십', style: TextStyle(color: Colors.black)),
                      ),
                      _buildDivider(),
                      TextButton(
                        onPressed: () {},
                        child: Text('가입하기', style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                  _buildDivider(isMainDivider: true),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text('Q 리워드', style: TextStyle(color: Colors.black)),
                      ),
                      _buildDivider(),
                      TextButton(
                        onPressed: () {},
                        child: Text('가입하기', style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),


            Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '라이프',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Divider(color: Colors.black),
                    SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1,
                      ),
                      itemCount: viewModel.iconItems.length,
                      itemBuilder: (context, index) {
                        final item = viewModel.iconItems[index];
                        return GestureDetector(
                          onTap: () {
                            print('${item.label} 버튼이 클릭됨');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SplashScreenSound()),
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.grey.shade200,
                                backgroundImage: AssetImage(item.iconPath),
                              ),
                              SizedBox(height: 8),
                              Text(
                                item.label,
                                style: TextStyle(color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // menuSections를 순회하며 각 섹션을 _buildMenuSection으로 빌드
            ...viewModel.menuSections.map((section) => _buildMenuSection(section as MenuModel)).toList(),
            SizedBox(height: 16),
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

  // 구분선 생성 함수
  Widget _buildDivider({bool isMainDivider = false}) {
    return Container(
      width: isMainDivider ? 1.5 : 1,
      height: 30,
      color: Colors.black,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
    );
  }

  // 메뉴 섹션을 빌드하는 함수
  Widget _buildMenuSection(MenuModel section) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              section.title,
              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Divider(color: Colors.black),
            Column(
              children: section.items
                  .map((item) => ListTile(
                title: Text(item),
                trailing: Icon(Icons.chevron_right),
                onTap: () {},
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
