// JSON 데이터를 받아서 객체를 생성할 수 있는 fromJson 생성자를 제공합니다. (사운드스케치 홈화면 관리)
class CardItem {
  final String title;
  final String imageUrl;
  final bool isLocal;

  CardItem({
    required this.title,
    required this.imageUrl,
    this.isLocal = false,
  });

  factory CardItem.fromJson(Map<String, dynamic> json) {
    return CardItem(
      title: json['title'] ?? 'Unknown Title',
      imageUrl: json['imageurl'] ?? 'assets/images/temp_image.png',
      isLocal: false,
    );
  }
}
