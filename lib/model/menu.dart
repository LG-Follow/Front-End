// 메뉴 모델
class MenuModel {
  final String title;
  final List<String> items;

  MenuModel({required this.title, required this.items});
}

class IconMenuItem {
  final String label;
  final String iconPath;

  IconMenuItem({required this.label, required this.iconPath});
}
