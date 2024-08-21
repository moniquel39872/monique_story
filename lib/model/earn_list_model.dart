class EarnListModel {
  final String? id;
  final String? title;
  final int? bonus;
  final String? image;
  final String? path;

  EarnListModel({
    this.id, 
    this.title, 
    this.bonus, 
    this.image, 
    this.path
  });

  factory EarnListModel.fromJson(Map<String, dynamic> json) {
    return EarnListModel(
      id: json['id'],
      title: json['title'],
      bonus: json['bonus'],
      image: json['image'],
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'bonus': bonus,
      'image': image,
      'path': path,
    };
  }
}
