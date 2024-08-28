class SigninHistoryModel {
  int? id;
  int? taskId;
  int? userId;
  int? points;
  String? signinDate;
  String? createdAt;

  SigninHistoryModel({
    this.id,
    this.taskId, 
    this.userId, 
    this.points,
    this.signinDate,
    this.createdAt,
  });

  factory SigninHistoryModel.fromJson(Map<String, dynamic> json) {
    return SigninHistoryModel(
      id: json['id'],
      taskId: json['task_id'],
      userId: json['user_id'],
      points: json['points'],
      signinDate: json['signin_date'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task_id': taskId,
      'user_id': userId,
      'points': points,
      'signin_date': signinDate,
      'created_at': createdAt,
    };
  }
}
