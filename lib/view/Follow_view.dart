// 앱 시작 화면, 로딩 화면입니다.
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
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
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
                      'assets/images/Follow.png',
                      height: 150,
                      width: 150,
                    ),
                    SizedBox(height: 8),

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
              'assets/images/lg_logo.png',
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}
