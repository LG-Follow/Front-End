class Song {
  final int id;
  final String title;
  final String description;
  final String songUrl; // songUrl 추가
  final double size;
  final String duration;
  final String createdAt;

  Song({
    required this.id,
    required this.title,
    required this.description,
    required this.songUrl, // 생성자에 추가
    required this.size,
    required this.duration,
    required this.createdAt,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      songUrl: json['songUrl'], // JSON 필드 매핑
      size: json['size'],
      duration: json['duration'],
      createdAt: json['createdAt'],
    );
  }
}
