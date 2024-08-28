class DailyTaskModel {
  int? id;
  String? taskType;
  String? taskName;
  int? points;
  bool? isSelected;
  bool? isCompleted;

  DailyTaskModel({
    this.id, 
    this.taskType, 
    this.taskName, 
    this.points, 
  });

  factory DailyTaskModel.fromJson(Map<String, dynamic> json) {
    return DailyTaskModel(
      id: json['id'],
      taskType: json['task_type'],
      taskName: json['task_name'],
      points: json['points'],      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task_type': taskType,
      'task_name': taskName,
      'points': points,
    };
  }
}
