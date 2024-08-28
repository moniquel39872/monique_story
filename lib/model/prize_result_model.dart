class PrizeResultModel {
  int? userId;
  String? orderNo;
  int? createAt;
  String? orderTaxId;

  PrizeResultModel({
    this.userId,
    this.orderNo, 
    this.createAt,
    this.orderTaxId,
  });

  factory PrizeResultModel.fromJson(Map<String, dynamic> json) {
    return PrizeResultModel(
      userId: json['user_id'],
      orderNo: json['o_no'],
      createAt: json['create_at'],
      orderTaxId: json['o_tx_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'o_no': orderNo,
      'create_at': createAt,
      'o_tx_id': orderTaxId,
    };
  }
}
