import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Future saveSettings(dynamic settings) async {
    settings = json.encode(settings);
    final preferences = await SharedPreferences.getInstance();
    preferences.setString('settings', settings);
  }

  Future<dynamic> getSettings() async {
    final preferences = await SharedPreferences.getInstance();
    return json.decode(preferences.getString('settings').toString());
  }
}
