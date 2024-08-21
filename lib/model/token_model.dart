
class TokenModel {
  TokenModel({
      this.apiToken, 
      this.refreshToken,      
    });

  TokenModel.fromJson(dynamic json) {
    apiToken = json['api_token'];
    refreshToken = json['refresh_token'];    
  }
  String? apiToken;
  String? refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['api_token'] = apiToken;
    map['refresh_token'] = refreshToken;   
   
    return map;
  }

}