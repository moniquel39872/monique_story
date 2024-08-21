class BackpackModel {
  int id;
  int eId;
  int userId;
  String name;
  String symbol;
  String image;
  int price;
  String amount;
  String? address;
  String? txHash;
  String createdAt;
  String? updatedAt;
  int status; //状态:-1禁用，1可用，2已提现，3申请中，4处理中，5异常

  BackpackModel({
    this.address,
    this.txHash,
    this.updatedAt,
    required this.id,
    required this.eId,
    required this.userId,
    required this.name,
    required this.symbol,
    required this.image,
    required this.price,
    required this.amount,    
    required this.createdAt,    
    required this.status,
  });

  factory BackpackModel.fromJson(Map<String, dynamic> json) {
    return BackpackModel(
      id: json['id'],
      eId: json['e_id'],
      userId: json['user_id'],
      name: json['name'],
      symbol: json['symbol'],
      image: json['image'],
      price: json['price'],
      amount: json['amount'],
      address: json['address'],
      txHash: json['tx_hash'],
      createdAt: json['create_at'],
      updatedAt: json['update_at'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'e_id': eId,
      'user_id': userId,
      'name': name,
      'symbol': symbol,
      'image': image,
      'price': price,
      'amount': amount,
      'address': address,
      'tx_hash': txHash,
      'create_at': createdAt,
      'update_at': updatedAt,
      'status': status,
    };
  }
}
