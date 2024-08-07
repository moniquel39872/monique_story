import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class AppJSON {
  static Future<Map<String, dynamic>> loadJsonObjFromAssets(
      String asset) async {
    String jsonString = await rootBundle.loadString('assets/${asset}');
    return jsonDecode(jsonString);
  }

  static Future<List<dynamic>> loadJsonArrayFromAssets(String asset) async {
    String jsonString = await rootBundle.loadString('assets/${asset}');
    return jsonDecode(jsonString) as List<dynamic>;
  }
}
