class OrderLogModel {
  int type;
  String outAmount;
  int status;
  int? createdAt;

  OrderLogModel({
    required this.type,
    required this.outAmount,
    required this.status,
    this.createdAt,
  });

  factory OrderLogModel.fromJson(Map<String, dynamic> json) {
    return OrderLogModel(
      type: json['type'],
      outAmount: json['out_amount'],
      status: json['status'],
      createdAt: json['create_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'out_amount': outAmount,
      'status': status,
      'create_at': createdAt,
    };
  }
}

class OrderLogListModel {
  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;
  final List<OrderLogModel> data;

  OrderLogListModel({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
    required this.data,
  });

  factory OrderLogListModel.fromJson(Map<String, dynamic> json) {
    return OrderLogListModel(
      total: json['total'],
      perPage: json['per_page'],
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      data: List<OrderLogModel>.from(
        json['data'].map((order) => OrderLogModel.fromJson(order))
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'per_page': perPage,
      'current_page': currentPage,
      'last_page': lastPage,
      'data': data.map((order) => order.toJson()).toList(),
    };
  }
}
