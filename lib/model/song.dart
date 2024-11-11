class Song {
  final String title;
  final String date;
  final String audioUrl;

  Song({required this.title, required this.date, required this.audioUrl});

  // 서버로부터 JSON 데이터를 객체로 변환하는 생성자
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      title: json['title'],
      date: json['date'],
      audioUrl: json['audioUrl'],
    );
  }
}
