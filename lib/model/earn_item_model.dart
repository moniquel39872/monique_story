class EarnItemModel {
  String? id;
  String? title;
  double? prize;
  String? date;

  EarnItemModel({
    this.id, 
    this.title, 
    this.prize, 
    this.date
  });

  factory EarnItemModel.fromJson(Map<String, dynamic> json) {
    return EarnItemModel(
      id: json['id'],
      title: json['title'],
      prize: json['prize'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'prize': prize,
      'date': date,
    };
  }
}
