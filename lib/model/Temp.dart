// 임시 저장

class Drawing {
  final String title;

  Drawing({required this.title});


  factory Drawing.fromJson(Map<String, dynamic> json) {
    return Drawing(
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
    };
  }
}
