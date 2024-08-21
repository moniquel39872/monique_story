// ignore_for_file: type_literal_in_constant_pattern, unreachable_switch_case

import 'package:kombat_flutter/model/add_gold_model.dart';
import 'package:kombat_flutter/model/exchange_model.dart';
import 'package:kombat_flutter/model/friend_model.dart';
import 'package:kombat_flutter/model/hotline_model.dart';
import 'package:kombat_flutter/model/mine_info_model.dart';
import 'package:kombat_flutter/model/morse_code_model.dart';
import 'package:kombat_flutter/model/order_log_model.dart';
import 'package:kombat_flutter/model/order_model.dart';
import 'package:kombat_flutter/model/token_model.dart';
import 'package:kombat_flutter/model/user_info_model.dart';
import 'package:kombat_flutter/utils/app_logger.dart';

class NetBaseEntity<T> {
  late int code;
  late String message;
  T? data;

  bool get isSuccess {
    return code == 200;
  }

  bool get noAuth {
    return code == 14010;
  }

  NetBaseEntity.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'] ?? '';
    if (code == 200) {
      if (json['data'] != null) {
        try {
          data = FlutterJsonBeanFactory.getData<T>(json['data']);
        } catch (e) {
          AppLogger.e(e);
          code = 400;
          message = "数据解析错误:${e.toString()}";
        }
      }
    } else if (noAuth) {}
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    map['data'] = data;
    return map;
  }
}

class NetBaseListEntity<T> {
  late int code;
  late String message;
  List<T>? data;

  bool get isSuccess {
    return code == 200;
  }

  NetBaseListEntity.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    if (code == 200) {
      if (json['data'] != null) {
        data = [];
        try {
          var list = json['data'];

          if (json['data'] is! List &&
              (json['data']['list'] != null ||
                  json['data']['dataList'] != null ||
                  json['data']['Data'] != null ||
                  json['data']['vip'] != null)) {
            //有时返回结果 ['list']有列表
            if (json['data']['list'] is List) {
              list = json['data']['list'];
            } else if (json['data']['dataList'] is List) {
              list = json['data']['dataList'];
            } else if (json['data']['Data'] is List) {
              list = json['data']['Data'];
            } else if (json['data']['vip'] is List) {
              list = json['data']['vip'];
            }
          }

          for (var element in (list as List)) {
            data!.add(FlutterJsonBeanFactory.getData<T>(element));
          }
        } catch (e) {
          code = 400;
          message = "数据解析错误:${e.toString()}";
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    map['data'] = data;
    return map;
  }
}

class FlutterJsonBeanFactory<T> {
  static dynamic getData<T>(dynamic json) {
    switch (T) {
      case String:
        return json.toString();
      // case LanguageTransModel:
      //   return LanguageTransModel.fromJson(json);
      case TokenModel:
        return TokenModel.fromJson(json);
      case UserInfoModel:
        return UserInfoModel.fromJson(json);
      case MineInfoModel:
        return MineInfoModel.fromJson(json);
      case OrderModel:
        return OrderModel.fromJson(json);
      case FriendModel:
        return FriendModel.fromJson(json);
      case HotlineModel:
        return HotlineModel.fromJson(json);
      case MorseCodeModel:
        return MorseCodeModel.fromJson(json);
      case ExchangeModel:
        return ExchangeModel.fromJson(json);
      case AddGoldModel:
        return AddGoldModel.fromJson(json);      
      case OrderListModel:
        return OrderListModel.fromJson(json);      
      case OrderLogListModel:
        return OrderLogListModel.fromJson(json);      
      default:
        return json;
    }
  }
}
