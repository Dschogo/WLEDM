import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wledm/utils/Websockethandler.dart';

class SettingsHandler {
  static final SettingsHandler _SettingsHandler = SettingsHandler._internal();

  factory SettingsHandler() {
    return _SettingsHandler;
  }

  SettingsHandler._internal();

  late SharedPreferences prefs;
  var settings = [];

  Future<http.Response> webget(adress) {
    return http.get(Uri.parse('http://$adress'));
  }

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
    settings = json.decode(prefs.getString('settings') ?? '[]');
    var to_remove = [];
    for (int i = 0; i < settings.length; i++) {
      if (!validator.ip(settings[i]['webadress'].toString().split(":")[0])) {
        print("removed ${settings[i]}");
        to_remove.add(i);
      }
    }
    for (var x in to_remove) {
      settings.removeAt(x);
    }
    saveSettings();
  }

  void saveSettings() {
    prefs.setString('settings', json.encode(settings));
  }

  List<dynamic> getSettings() {
    settings = json.decode(prefs.getString('settings').toString());
    return settings;
  }

  void addInstance(String name, String webadress) {
    if (settings.toString().contains(webadress)) {
      print('Instance already exists');
      return;
    }
    settings.add({"name": name, "webadress": webadress});
    print(settings);
    saveSettings();
    WebsocketHandler().getWebsocket(webadress);
  }

  void delteInstance(String webadress) {
    WebsocketHandler().closeWebsocket(webadress);
    settings.removeWhere((item) => item['webadress'] == webadress);
    print(settings);
    saveSettings();
  }
}
