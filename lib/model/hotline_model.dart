class HotlineModel {
  String? lang;
  String? skin;
  bool? showGuide;

  HotlineModel({
    this.lang,
    this.skin,
    this.showGuide,
  });

  HotlineModel.fromJson(dynamic json) {
    lang = json['lang'];
    skin = json['skin'];
    showGuide = json['showGuide'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lang'] = lang;
    map['skin'] = skin;
    map['showGuide'] = showGuide;
    return map;
  }
}