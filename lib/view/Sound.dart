// 사운드 스케치 아이콘을 클릭하면 생성되는 로딩 화면
import 'package:flutter/material.dart';
import '../view/sketch_home_view.dart';


class SplashScreenSound extends StatefulWidget {
  @override
  _SplashScreenSoundState createState() => _SplashScreenSoundState();
}

class _SplashScreenSoundState extends State<SplashScreenSound> {
  @override
  void initState() {
    super.initState();
    // 5초 후에 로그인 화면으로 이동
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SketchHomeView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Transform.translate(
                offset: Offset(0, -50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // LG Follow 로고 이미지
                    Image.asset(
                      'assets/images/sound.png',
                      height: 150,
                      width: 150,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
          // 하단 LG전자 로고
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Image.asset(
              'assets/images/lg_logo.png', // LG 로고 이미지 경로
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}
