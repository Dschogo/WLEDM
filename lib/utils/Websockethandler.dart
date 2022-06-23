import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketHandler {
  static final WebsocketHandler _WebsocketHandler =
      WebsocketHandler._internal();

  factory WebsocketHandler() {
    return _WebsocketHandler;
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
