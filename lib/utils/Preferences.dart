import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Preferences {
  var somejsonshit = [
    {"name": "ichi", "webadress": "192.168.178.63:91"},
    {"name": "ni", "webadress": "192.168.178.63:92"}
  ];

  var settings = [];
  var streams = {};

  getWebsocket(String adrress) {
    if (streams.containsKey(adrress)) {
      return streams[adrress];
    } else {
      streams[adrress] =
          WebSocketChannel.connect(Uri.parse('ws://$adrress/ws'));
      return streams[adrress];
    }
  }

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
