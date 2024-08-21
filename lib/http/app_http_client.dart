
import 'package:dio/dio.dart' hide Headers;
import 'package:kombat_flutter/http/response_model.dart';
import 'package:kombat_flutter/model/add_gold_model.dart';
import 'package:kombat_flutter/model/backpack_model.dart';
import 'package:kombat_flutter/model/exchange_model.dart';
import 'package:kombat_flutter/model/friend_model.dart';
import 'package:kombat_flutter/model/mine_info_model.dart';
import 'package:kombat_flutter/model/morse_code_model.dart';
import 'package:kombat_flutter/model/order_log_model.dart';
import 'package:kombat_flutter/model/order_model.dart';
import 'package:kombat_flutter/model/token_model.dart';
import 'package:kombat_flutter/model/user_info_model.dart';
import 'package:retrofit/retrofit.dart';

part 'app_http_client.g.dart';

@RestApi()
abstract class AppHttpClient {
  factory AppHttpClient(Dio dio, {String baseUrl}) = _AppHttpClient;

  @POST('/Sign/in')
  Future<NetBaseEntity<TokenModel>> signIn(
    @Field("w") String walletAddress
  );

  @POST('/User/index')
  Future<NetBaseEntity<UserInfoModel>> getUserInfo();

  @POST('/User/friends')
  Future<NetBaseListEntity<FriendModel>> getFriends();

  @POST('/User/mine')
  Future<NetBaseEntity<MineInfoModel>> getMineInfo();

  @POST('/User/addGold')
  Future<NetBaseEntity<AddGoldModel>> addGold(
    @Field("gold") int gold
  );

  @POST('/User/morseCode')
  Future<NetBaseEntity<MorseCodeModel>> getMorseCode();

  @POST('/User/morseVerify')
  Future<NetBaseEntity<int>> morseVerify(
    @Field("letters") String letters
  );

  @POST('/User/order')
  Future<NetBaseEntity<OrderListModel>> getOrderList();

  @POST('/User/orderLog')
  Future<NetBaseEntity<OrderLogListModel>> getOrderLogList(
    @Field("type") int type
  );

  @POST('/Exchange')
  Future<NetBaseListEntity<ExchangeModel>> getExchange();

  @POST('/Exchange/trade')
  Future<NetBaseEntity<String>> exchangeTrade(
    @Field("e_id") int eId
  );

  @POST('/Exchange/backpack')
  Future<NetBaseListEntity<BackpackModel>> getBackpack();

  @POST('/Exchange/receive')
  Future<NetBaseEntity<String>> withdrawal(
    @Field("id") int id,
    @Field("address") String address
  );
}
