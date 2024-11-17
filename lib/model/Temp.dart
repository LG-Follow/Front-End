// model

class Drawing {
  final String title;

  Drawing({required this.title});

  // JSON 데이터를 객체로 변환하는 생성자
  factory Drawing.fromJson(Map<String, dynamic> json) {
    return Drawing(
      title: json['title'],
    );
  }

  // 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'title': title,
    };
  }
}
