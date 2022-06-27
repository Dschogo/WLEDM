// ignore_for_file: file_names

import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketHandler {
  static final WebsocketHandler _websocketHandler =
      WebsocketHandler._internal();

  factory WebsocketHandler() {
    return _websocketHandler;
  }

  WebsocketHandler._internal();

  var streams = {};

  getWebsocket(String adrress) {
    if (streams.containsKey(adrress)) {
      return streams[adrress];
    } else {
      streams[adrress] =
          WebSocketChannel.connect(Uri.parse('ws://$adrress/ws'));
      return [streams[adrress].stream.asBroadcastStream(), adrress];
    }
  }

  bool isWSconnected(String adrress) {
    if (streams.containsKey(adrress)) {
      return true;
    } else {
      return false;
    }
  }

  closeWebsocket(String adrress) {
    if (streams.containsKey(adrress)) {
      streams[adrress].sink.close();
      streams.remove(adrress);
    }
  }

  sinkWebsocket(String adrress, dynamic message) {
    if (streams.containsKey(adrress)) {
      streams[adrress].sink.add(message);
    }
  }
}

// class WledWebsocket {
//   WLED wled;
//   WebSocketChannel channel;
//   Stream<dynamic> broadcast;
//   String adress;

//   WledWebsocket({
//     required this.wled,
//     required this.channel,
//     required this.broadcast,
//     required this.adress,
//   });

//   void sink(dynamic message) {
//     channel.sink.add(message);
//   }

//   Future<WLED> loadstate(data) async {
//     final response =
//         await http.get(Uri.parse("http://${data["webadress"]}/json"));
//     if (response.statusCode == 200) {
//       // If the server did return a 200 OK response,
//       // then parse the JSON.
//       return WLED.fromJson(jsonDecode(response.body));
//     } else {
//       // If the server did not return a 200 OK response,
//       // then throw an exception.
//       throw Exception('Failed to load album');
//     }
//   }

//   factory WledWebsocket.newWLED(String address) {
//     WebSocketChannel ws =
//         WebSocketChannel.connect(Uri.parse('ws://$address/ws'));

//     return WledWebsocket(
//       wled: loadstate(address),
//       channel: ws,
//       broadcast: ws.stream.asBroadcastStream(),
//       adress: address,
//     );
//   }
// }
