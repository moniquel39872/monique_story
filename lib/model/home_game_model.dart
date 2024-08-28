import 'package:kombat_flutter/model/game_prize_model.dart';
import 'package:kombat_flutter/model/prize_model.dart';

class HomeGameModel {
  List<GamePrizeModel>? data;
  PrizeModel? prize;  

  HomeGameModel({
    this.data,
    this.prize, 
  });

  factory HomeGameModel.fromJson(Map<String, dynamic> json) {
    return HomeGameModel(
      prize: PrizeModel.fromJson(json['prize']),
      data: List<GamePrizeModel>.from(
        json['data'].map((d) => GamePrizeModel.fromJson(d))
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prize': prize?.toJson(),
      'data': data?.map((d) => d.toJson()).toList(),      
    };
  }
}
