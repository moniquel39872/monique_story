class RechargeModel {
  final String? toAddress;
  final double? balance;
  final double? fee;

  RechargeModel({
    this.toAddress, 
    this.balance, 
    this.fee, 
  });

  factory RechargeModel.fromJson(Map<String, dynamic> json) {
    return RechargeModel(
      toAddress: json['toAddress'],
      balance: json['balance'],
      fee: json['fee'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'toAddress': toAddress,
      'balance': balance,
      'fee': fee,
    };
  }
}
