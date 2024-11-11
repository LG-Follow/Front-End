import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModel/home_view_model.dart';
import '../model/home.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '우리집',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {},
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('스마트 추천', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black,
                  size: 18,
                )
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    shadowColor: Colors.white38, // 입체감
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.black, width: 2),
                  ),
                  onPressed: viewModel.toggleFollowAllOff,
                  child: Text(
                    'Follow 전체 ${viewModel.followAllOff ? "off" : "on"}',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    shadowColor: Colors.white38, // 입체감
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.black, width: 2),
                  ),
                  onPressed: viewModel.toggleAirConditionerOnlyOff,
                  child: Text(
                    '에어컨만 기능 ${viewModel.airConditionerOnlyOff ? "off" : "on"}',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('거실', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.5,
                ),
                itemCount: viewModel.devices.length + 1, // 가전 제품 목록 + '가전 추가' 버튼
                itemBuilder: (context, index) {
                  if (index < viewModel.devices.length) {
                    final device = viewModel.devices[index];
                    return _buildDeviceCard(device, index, viewModel);
                  } else {
                    return _buildAddDeviceCard(context); // 여기에서 context 전달
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          _onTapBottomNavigator(context, index);
        },
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

  void _onTapBottomNavigator(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
      // 여기에 디스커버 페이지 추가
        break;
      case 2:
      // 여기에 리포트 페이지 추가
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/menu');
        break;
      default:
        break;
    }
  }

  // 가전 제품 카드 생성
  Widget _buildDeviceCard(HomeDeviceModel device, int index, HomeViewModel viewModel) {
    return Card(
      elevation: 4, // 입체감
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.black),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(device.iconPath, width: 40, height: 40),
                SizedBox(height: 10),
                Text(
                  device.name,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: IconButton(
                    icon: Icon(device.isOn ? Icons.power_settings_new : Icons.power_off_outlined),
                    onPressed: () => viewModel.toggleDevicePower(index),
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: IconButton(
                    icon: Icon(device.isOn ? Icons.volume_up : Icons.volume_off),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // '가전 추가' 카드 생성
  Widget _buildAddDeviceCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/add'); // 페이지 이동
      },
      child: Card(
        elevation: 4, // 입체감
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.black),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 30, color: Colors.black),
              SizedBox(height: 5),
              Text(
                '가전 추가',
                style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        color: Colors.white,
      ),
    );
  }
}

