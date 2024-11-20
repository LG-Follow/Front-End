import 'package:flutter/material.dart';
import '../view/Login_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 5초 후에 로그인 화면으로 이동
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginView()), // LoginScreen으로 이동
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
                offset: Offset(0, -50), // 중앙보다 50픽셀 위로 이동
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // LG Follow 로고 이미지
                    Image.asset(
                      'assets/images/Follow.png',
                      height: 150,
                      width: 150,
                    ),
                    SizedBox(height: 8),
                    // 사용자 추적 사운드 텍스트
                    Text(
                      'Follow your Experience',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
