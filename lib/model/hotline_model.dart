class HotlineModel {
  String? lang;
  String? skin;

  HotlineModel({
    this.lang,
    this.skin,
  });

  HotlineModel.fromJson(dynamic json) {
    lang = json['lang'];
    skin = json['skin'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lang'] = lang;
    map['skin'] = skin;
    return map;
  }
}