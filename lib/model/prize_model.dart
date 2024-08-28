class PrizeModel {
  int? prizeId;
  int? i;
  int? status;
  int? createAt;
  int? updateAt;
  int? finishAt;

  PrizeModel({
    this.prizeId,
    this.i, 
    this.status, 
    this.createAt,
    this.updateAt,
    this.finishAt,
  });

  factory PrizeModel.fromJson(Map<String, dynamic> json) {
    return PrizeModel(
      prizeId: json['prize_id'],
      i: json['i'],
      status: json['status'],
      createAt: json['create_at'],
      updateAt: json['update_at'],
      finishAt: json['finish_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prize_id': prizeId,
      'i': i,
      'status': status,
      'create_at': createAt,
      'update_at': updateAt,
      'finish_at': finishAt,
    };
  }
}
