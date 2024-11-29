// 메뉴를 구성하는 기능
import 'package:flutter/material.dart';
import '../model/menu.dart';

class MenuViewModel extends ChangeNotifier {
  // 메뉴 섹션 데이터
  List<MenuModel> menuSections = [
    MenuModel(title: '제품 사용과 관리', items: ['스마트 루틴', '스마트 진단', '제품 정보와 보증', '제품 사용설명서']),
    MenuModel(title: '제품 업그레이드', items: ['UP가전센터', 'UP가전 아이디어 제안']),
    MenuModel(title: '고객 지원', items: ['공지사항', '문의하기', 'LG전자 서비스', 'ChatThinQ']),
  ];

  // 추천 아이콘 데이터
  List<IconMenuItem> iconItems = [
    IconMenuItem(label: '에너지', iconPath: 'assets/images/energy.png'),
    IconMenuItem(label: '우리 단지', iconPath: 'assets/images/our_apt.png'),
    IconMenuItem(label: 'LG AI Fit', iconPath: 'assets/images/ai_fit.png'),
    IconMenuItem(label: 'SoundSketch', iconPath: 'assets/images/SoundSketch.png'),
  ];
}
