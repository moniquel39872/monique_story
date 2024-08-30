class ChartDataModel {
  final String date;
  final dynamic total;

  ChartDataModel({
    required this.date, 
    required this.total, 
  });

  factory ChartDataModel.fromJson(Map<String, dynamic> json) {
    return ChartDataModel(
      date: json['date'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'total': total,
    };
  }
}
