class ExchangeModel {
  final int id;
  final String name;
  final String symbol;
  final String image;
  final int price;
  final String amount;
  final int amountLimit;
  final int timeLimit; //0-Unlimited
  final int status; //1禁用，1正常，2已兑完

  ExchangeModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.image,
    required this.price,
    required this.amount,
    required this.amountLimit,
    required this.timeLimit,
    required this.status,
  });

  factory ExchangeModel.fromJson(Map<String, dynamic> json) {
    return ExchangeModel(
      id: json['e_id'],
      name: json['name'],
      symbol: json['symbol'],
      image: json['image'],
      price: json['price'],
      amount: json['amount'],
      amountLimit: json['amount_limit'],
      timeLimit: json['time_limit'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'e_id': id,
      'name': name,
      'symbol': symbol,
      'image': image,
      'price': price,
      'amount': amount,
      'amount_limit': amountLimit,
      'time_limit': timeLimit,
      'status': status,
    };
  }
}
