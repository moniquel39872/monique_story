
class UserInfoModel {
  UserInfoModel({
    this.userName, 
    this.uId,
    this.pId,
    this.avatar, 
    this.gold, 
    this.level,
    this.points,
    this.status,
    this.lang,
    this.withdrawTotal, 
    this.rechargeTotal, 
    this.rechargeCount,
    this.runningTotal, 
    this.runningCount,
    this.invitTotal, 
    this.invitCount,
    this.regIp,
    this.loginIp, 
    this.createAt,
    this.updateAt,
  });

  UserInfoModel.fromJson(dynamic json) {
    userName = json['user_name'];
    uId = json['u_id'];
    pId = json['p_id'];
    avatar = json['avatar'];
    gold = json['gold'];
    level = json['level'];
    points = json['points'];
    status = json['status'];
    lang = json['lang'];
    withdrawTotal = json['withdraw_total'];
    rechargeTotal = json['recharge_total'];
    rechargeCount = json['recharge_count'];
    runningTotal = json['running_total'];
    runningCount = json['running_count'];
    invitTotal = json['invit_total'];
    invitCount = json['invit_count'];
    loginIp = json['login_ip'];
    regIp = json['reg_ip'];
    createAt = json['create_at'];
    updateAt = json['update_at'];
  }
  String? userName;
  String? uId;
  String? pId;
  int? avatar;
  int? gold;
  int? level;
  int? points;
  int? status;
  String? lang;
  String? withdrawTotal;  
  String? rechargeTotal;
  int? rechargeCount;
  String? runningTotal;
  int? runningCount;
  String? invitTotal;
  int? invitCount;
  String? regIp;
  String? loginIp;
  int? createAt;
  int? updateAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = userName;
    map['avatar'] = avatar;
    map['u_id'] = uId;
    map['p_id'] = pId;
    map['gold'] = gold;
    map['level'] = level;
    map['points'] = points;
    map['level'] = level;
    map['status'] = status;
    map['lang'] = lang;
    map['withdraw_total'] = withdrawTotal;
    map['recharge_total'] = rechargeTotal;
    map['recharge_count'] = rechargeCount;
    map['running_total'] = runningTotal;
    map['running_count'] = runningCount;
    map['invit_total'] = invitTotal;
    map['invit_count'] = invitCount;
    map['login_ip'] = loginIp;
    map['reg_ip'] = regIp;
    map['create_at'] = createAt;
    map['update_at'] = updateAt;
   
    return map;
  }

}