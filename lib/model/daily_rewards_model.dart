class DailyRewardsModel {
  String? title;
  String? coins;
  bool? isEnable;
  bool? isSelected;
  bool? isCompleted;

  DailyRewardsModel({
    this.title,
    this.coins,
    this.isEnable,
    this.isSelected,
    this.isCompleted
  });

  DailyRewardsModel.fromJson(dynamic json) {
    title = json['title'];
    coins = json['coins'];
    isEnable = json['isEnable'];
    isSelected = json['isSelected'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['coins'] = coins;
    map['isEnable'] = isEnable;
    map['isSelected'] = isSelected;
    map['isCompleted'] = isCompleted;
    return map;
  }

  @override
  bool operator ==(Object other) {
    return (other is DailyRewardsModel) && other.title == title  && other.coins == coins
     && other.isEnable == isEnable  && other.isSelected == isSelected && other.isCompleted == isCompleted;
  }
}