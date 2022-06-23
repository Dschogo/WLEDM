//  ignore_for_file: file_names
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Preferences {
  var somejsonshit = [
    {"name": "ichi", "webadress": "192.168.178.63:91"},
    {"name": "ni", "webadress": "192.168.178.63:92"}
  ];

  var settings = [];

  Future<http.Response> webget(adress) {
    return http.get(Uri.parse('http://$adress'));
  }

  Future asyncsaveSettings() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString('settings', json.encode(settings));
  }

  Future<dynamic> asyncgetSettings() async {
    final preferences = await SharedPreferences.getInstance();
    settings = json.decode(preferences.getString('settings') ?? '[]');
    return settings;
  }

  void addInstance(String name, String webadress) {
    somejsonshit.add({"name": name, "webadress": webadress});
    asyncsaveSettings();
  }

  void delteInstance(String name) {
    somejsonshit.removeWhere((item) => item['name'] == name);
    asyncsaveSettings();
  }
}
