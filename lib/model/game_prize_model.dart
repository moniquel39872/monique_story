class GamePrizeModel {
  int? orderId;
  int? prizeId;
  int? userId;
  String? orderAmount;
  int? fast;
  int? status;
  int? createAt;
  int? updateAt;  

  GamePrizeModel({
    this.orderId,
    this.prizeId,
    this.userId, 
    this.orderAmount,
    this.fast,
    this.status, 
    this.createAt,
    this.updateAt,    
  });

  factory GamePrizeModel.fromJson(Map<String, dynamic> json) {
    return GamePrizeModel(
      orderId: json['o_id'],
      prizeId: json['prize_id'],
      userId: json['user_id'],
      orderAmount: json['o_amount'],
      fast: json['fast'],
      status: json['status'],
      createAt: json['create_at'],
      updateAt: json['update_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'o_id': orderId,
      'prize_id': prizeId,
      'user_id': userId,
      'o_amount': orderAmount,
      'fast': fast,
      'status': status,
      'create_at': createAt,
      'update_at': updateAt,      
    };
  }
}
