class SkinModel {
  String code;
  String? icon;
  String? label;
  String? type;
  String? desc;
  int? price;

  SkinModel({
    this.icon,
    this.label,
    this.type,
    this.desc,
    this.price,
    required this.code,
  });
}
