class FriendModel {
  final String address;
  final String userName;
  final int avatar;
  final int status;
  final int? updatedAt;
  final int createdAt;

  FriendModel({
    required this.address,
    required this.userName,
    required this.avatar,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      address: json['address'],
      userName: json['user_name'],
      avatar: json['avatar'],
      status: json['status'],
      updatedAt: json['update_at'],
      createdAt: json['create_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'user_name': userName,
      'avatar': avatar,
      'status': status,
      'update_at': updatedAt,
      'create_at': createdAt,
    };
  }
}
