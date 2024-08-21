class OrderModel {
  int orderId;
  String orderNo;
  int prizeId;
  int userId;
  String uId;
  String orderTaxId;
  int orderTaxIndex;
  String orderTo;
  String orderAmount;
  String outAmount;
  String outTotal;
  int outCount;  
  int fast;
  int status;
  int createdAt;
  int? updateAt;

  OrderModel({
    this.updateAt,
    required this.orderId,
    required this.orderNo,
    required this.prizeId,
    required this.userId,
    required this.uId,
    required this.orderTaxId,
    required this.orderTaxIndex,
    required this.orderTo,
    required this.orderAmount,
    required this.outAmount,
    required this.outTotal,
    required this.outCount,
    required this.fast,
    required this.status,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['o_id'],
      orderNo: json['o_no'],
      prizeId: json['prize_id'],
      userId: json['user_id'],
      uId: json['u_id'],
      orderTaxId: json['o_tx_id'],
      orderTaxIndex: json['o_tx_index'],
      orderTo: json['o_to'],
      orderAmount: json['o_amount'],
      outAmount: json['out_amount'],
      outTotal: json['out_total'],
      outCount: json['out_count'],
      fast: json['fast'],
      status: json['status'],
      createdAt: json['create_at'],
      updateAt: json['update_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'o_id': orderId,
      'o_no': orderNo,
      'prize_id': prizeId,
      'user_id': userId,
      'u_id': uId,
      'o_tx_id': orderTaxId,
      'o_tx_index': orderTaxIndex,
      'o_to': orderTo,
      'o_amount': orderAmount,
      'out_amount': outAmount,
      'out_total': outTotal,
      'out_count': outCount,
      'fast': fast,
      'status': status,
      'create_at': createdAt,
      'update_at': updateAt,
    };
  }
}

class OrderListModel {
  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;
  final List<OrderModel> data;

  OrderListModel({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
    required this.data,
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) {
    return OrderListModel(
      total: json['total'],
      perPage: json['per_page'],
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      data: List<OrderModel>.from(
        json['data'].map((order) => OrderModel.fromJson(order))
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
