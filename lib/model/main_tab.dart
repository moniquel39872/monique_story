class MainTabModel {
  String code;
  String? icon;
  String? label;
  String navPath;

  MainTabModel({
    this.icon,
    this.label,
    required this.code,
    required this.navPath,
  });
}
