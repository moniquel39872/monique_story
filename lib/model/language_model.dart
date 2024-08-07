class LanguageModel {
  String? code;
  String? name;
  String? shortName;

  LanguageModel({
    this.code,
    this.name,
    this.shortName
  });

  LanguageModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      code = json['code'];
      name = json['name'];
      shortName = json['shortName'];
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['name'] = name;
    map['shortName'] = shortName;
    
    return map;
  }
}