import 'dart:convert';

class JsonUtils {
  static Map<String, dynamic> parseJson(String json) {
    Map<String, dynamic> jsonObject;
    try {
      jsonObject = json as Map<String, dynamic>;
    } catch (er) {
      return jsonDecode(json);
    }
    return jsonObject;
  }
}
