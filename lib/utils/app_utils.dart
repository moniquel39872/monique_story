import 'package:intl/intl.dart';
class AppUtils{
  static String intToStrWithComma(int a) {
    final value = new NumberFormat("#,##0", "en_US");
    return value.format(a);
  }
}