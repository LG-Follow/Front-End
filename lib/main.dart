import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lg_follow/view/Login_view.dart';
import 'package:lg_follow/view/home_view.dart';
import 'package:lg_follow/view/menu_view.dart';
import 'package:lg_follow/viewModel/Login_view_model.dart';
import 'package:lg_follow/viewModel/home_view_model.dart';
import 'package:lg_follow/viewModel/menu_view_model.dart';
import 'package:provider/provider.dart';
import 'package:lg_follow/view/Follow_view.dart';
import 'package:lg_follow/view/product_view.dart';
import 'package:lg_follow/viewModel/product_view_model.dart';
import 'package:lg_follow/viewModel/qr_scan_view_model.dart';
import 'package:lg_follow/view/qr_scan_view.dart';
import 'package:lg_follow/view/Sound.dart';
import 'package:lg_follow/viewModel/sketch_home_view_model.dart';
import 'package:lg_follow/viewModel/song_view_model.dart';
import 'package:lg_follow/viewModel/Drawing_view_model.dart';
import 'package:lg_follow/view/Drawing_view.dart';

Future<void> main() async {
  // .env 파일 로드
  await dotenv.load(fileName: ".env");
  // 앱 실행
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => MenuViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => MenuViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => QRScanViewModel()),
        ChangeNotifierProvider(create: (_) => SketchViewModel()),
        ChangeNotifierProvider(create: (_) => SongViewModel()),
        ChangeNotifierProvider(create: (_) => DrawingViewModel()),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          'login': (context) => LoginView(),
          '/menu': (context) => MenuView(),
          '/home': (context) => HomeView(),
          '/menu': (context) => MenuView(),
          '/add' : (context) => ProductView(),
          '/scan' : (context) => QRScanView(),
          'sound' : (context) => SplashScreenSound(),

        },
      ),
    );
  }
}

