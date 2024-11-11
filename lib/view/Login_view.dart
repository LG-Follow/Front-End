// views/login_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModel/Login_view_model.dart';
import 'home_view.dart';


class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            Align(
              alignment: Alignment.centerLeft, // Image.asset을 좌측 정렬
              child: Image.asset(
                'assets/images/lg_logo.png', // LG 로고 이미지 경로
                width: 150,
                height: 50,
              ),
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '이메일 아이디 또는 휴대폰 번호 아이디',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
            TextField(
              onChanged: (value) => viewModel.setEmailOrPhone(value),
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '비밀번호',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => viewModel.setPassword(value),
                    obscureText: !viewModel.isPasswordVisible,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(viewModel.isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: viewModel.togglePasswordVisibility,
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white38,
                minimumSize: Size(double.infinity, 45),
              ),
              onPressed: () {
                // 유효성 검사 후 홈 화면으로 이동
                if (viewModel.validateCredentials()) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeView()),
                  );
                } else {
                  // 유효하지 않은 경우 메시지 표시
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('이메일과 비밀번호를 입력해주세요.'),
                    ),
                  );
                }
              },
              child: Text(
                '로그인',
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black, // 텍스트 색상을 검정으로 설정
                  ),
                  child: Text('아이디 찾기'),
                ),
                Text('|', style: TextStyle(color: Colors.black)),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black, // 텍스트 색상을 검정으로 설정
                  ),
                  child: Text('비밀번호 재설정'),
                ),
                Text('|', style: TextStyle(color: Colors.black)),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black, // 텍스트 색상을 검정으로 설정
                  ),
                  child: Text(
                    '회원가입',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
