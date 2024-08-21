class SkinModel {
  int id;
  String code;
  String? icon;
  String? label;
  String? type;
  String? desc;
  int? price;

  SkinModel({
    required this.id,
    this.icon,
    this.label,
    this.type,
    this.desc,
    this.price,
    required this.code,
  });
}
