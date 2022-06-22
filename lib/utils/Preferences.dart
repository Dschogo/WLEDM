import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class Preferences {
  var somejsonshit = [
    {"name": "ichi", "webadress": "192.168.178.63:91"},
    {"name": "ni", "webadress": "192.168.178.63:92"}
  ];

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
