
import 'package:dio/dio.dart' hide Headers;
import 'package:kombat_flutter/http/response_model.dart';
import 'package:kombat_flutter/model/add_gold_model.dart';
import 'package:kombat_flutter/model/backpack_model.dart';
import 'package:kombat_flutter/model/chart_data_model.dart';
import 'package:kombat_flutter/model/daily_task_model.dart';
import 'package:kombat_flutter/model/exchange_model.dart';
import 'package:kombat_flutter/model/friend_model.dart';
import 'package:kombat_flutter/model/game_prize_model.dart';
import 'package:kombat_flutter/model/home_game_model.dart';
import 'package:kombat_flutter/model/mine_info_model.dart';
import 'package:kombat_flutter/model/morse_code_model.dart';
import 'package:kombat_flutter/model/order_log_model.dart';
import 'package:kombat_flutter/model/order_model.dart';
import 'package:kombat_flutter/model/prize_result_model.dart';
import 'package:kombat_flutter/model/recharge_model.dart';
import 'package:kombat_flutter/model/signin_history_model.dart';
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

  @POST('/User/incomeCharts')
  Future<NetBaseListEntity<ChartDataModel>> getChartData(
    @Field("type") int type,
    @Field("days") int days
  );

  @POST('/User/recharge')
  Future<NetBaseEntity<RechargeModel>> recharge();

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

  @POST('/Index/index')
  Future<NetBaseEntity<HomeGameModel>> getHomeGame();

  @POST('/Index/prize')
  Future<NetBaseEntity<PrizeResultModel>> checkPrize(
    @Field("prize_id") int prizeId
  );

  @POST('/Tasks/getToday')
  Future<NetBaseListEntity<DailyTaskModel>> getDailyTask();

  @POST('/Tasks/userSignin')
  Future<NetBaseEntity<String>> completeSigninTask();

  @POST('/Tasks/getSigninHistory')
  Future<NetBaseListEntity<SigninHistoryModel>> getSigninHistory();
}
