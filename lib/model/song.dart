// 서버로부터 받아오는 데이터를 fromJson을 통해 객체 생성, 음악 재생 관련
import 'package:intl/intl.dart'; // 날짜 포맷팅을 위한 패키지

class Song {
  final int id;
  final String title;
  final String duration;
  final String songUrl;
  final String imageUrl;
  final DateTime createdAt;

  Song({
    required this.id,
    required this.title,
    required this.duration,
    required this.songUrl,
    required this.imageUrl,
    required this.createdAt,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
      songUrl: json['songUrl'],
      imageUrl: json['imageUrl'],
      createdAt: DateTime.parse(json['createdAt']), // JSON의 날짜를 DateTime으로 변환
    );
  }

  // createdAt을 String으로 반환하기 위한 메서드
  String get formattedDate {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(createdAt);
  }
}
