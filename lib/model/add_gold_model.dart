class AddGoldModel {
  final String? id;
  final String? userId;
  final String? date;
  final String? golds;
  final String? dailyGoldsLimit;

  AddGoldModel({
    this.id, 
    this.userId, 
    this.date, 
    this.golds, 
    this.dailyGoldsLimit
  });

  factory AddGoldModel.fromJson(Map<String, dynamic> json) {
    return AddGoldModel(
      id: json['id'],
      userId: json['user_id'],
      date: json['date'],
      golds: json['golds'],
      dailyGoldsLimit: json['daily_golds_limit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'date': date,
      'golds': golds,
      'daily_golds_limit': dailyGoldsLimit,
    };
  }
}
