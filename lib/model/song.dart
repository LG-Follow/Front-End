// 서버로부터 받아오는 데이터를 fromJson을 통해 객체 생성, 음악 재생 관련
import 'package:intl/intl.dart'; // 날짜 포맷팅을 위한 패키지

class Song {
  final int id;
  final String title;
  final String description;
  final String songUrl;
  final double size;
  final Duration duration; // Duration 타입
  final DateTime createdAt;
  final String imageUrl;

  Song({
    required this.id,
    required this.title,
    required this.description,
    required this.songUrl,
    required this.size,
    required this.duration,
    required this.createdAt,
    required this.imageUrl,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown Title',
      description: json['description'] ?? '',
      songUrl: json['song_url'] ?? '',
      size: (json['size'] ?? 0).toDouble(),
      duration: parseDuration(json['duration'] ?? '00:00:00'), // 문자열 -> Duration 변환
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      imageUrl: json['image_url'] ?? 'assets/images/temp_image.png',
    );
  }

  // 문자열을 Duration 객체로 변환하는 함수
  static Duration parseDuration(String duration) {
    final parts = duration.split(':');
    if (parts.length == 3) {
      final hours = int.tryParse(parts[0]) ?? 0;
      final minutes = int.tryParse(parts[1]) ?? 0;
      final seconds = int.tryParse(parts[2]) ?? 0;
      return Duration(hours: hours, minutes: minutes, seconds: seconds);
    } else if (parts.length == 2) {
      final minutes = int.tryParse(parts[0]) ?? 0;
      final seconds = int.tryParse(parts[1]) ?? 0;
      return Duration(minutes: minutes, seconds: seconds);
    }
    return Duration.zero;
  }
}
