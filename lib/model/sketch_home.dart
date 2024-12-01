class CardItem {
  final String title;
  final String imageUrl;
  final bool isLocal;

  CardItem({
    required this.title,
    required this.imageUrl,
    required this.isLocal,
  });

  factory CardItem.fromJson(Map<String, dynamic> json) {
    final imageUrl = json['image_url'] ?? 'assets/images/temp_image.png';
    return CardItem(
      title: json['title'] ?? 'Unknown Title',
      imageUrl: imageUrl,
      isLocal: !imageUrl.startsWith('http'), // HTTP/HTTPS로 시작하지 않으면 로컬로 간주
    );
  }
}

