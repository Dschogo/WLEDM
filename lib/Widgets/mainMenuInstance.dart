// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:wledm/Screens/instancemanager.dart';
import 'package:wledm/custom/WLED.dart';
import 'package:http/http.dart' as http;
import 'package:wledm/utils/Websockethandler.dart';
import 'package:wledm/utils/constants.dart';
import 'package:wledm/utils/widget_functions.dart';

class MainMenuInstance extends StatefulWidget {
  const MainMenuInstance({Key? key, required this.data}) : super(key: key);

  final dynamic data;

  @override
  State<MainMenuInstance> createState() => _MainMenuInstanceState();
}

class _MainMenuInstanceState extends State<MainMenuInstance> {
  dynamic data;
  dynamic channel;
  late Future<WLED> wledfuture;
  late WLED wled;

  var time = DateTime.now().millisecondsSinceEpoch;

  Future<WLED> loadstate(data) async {
    final response =
        await http.get(Uri.parse("http://${data["webadress"]}/json"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return WLED.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    data = widget.data;
    channel = WebsocketHandler().getWebsocket(data['webadress']);
    wledfuture = loadstate(data);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
        width: size.width,
        height: size.height,
        child: FutureBuilder<WLED>(
          future: wledfuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              wled = snapshot.data!;
              return StreamBuilder(
                  stream: channel[0],
                  builder: (context, streamsnapshot) {
                    if (streamsnapshot.hasData) {
                      wled = wled
                          .update(jsonDecode(streamsnapshot.data as String));
                    }
                    return Container(
                        margin: const EdgeInsets.only(left: 10, top: 10),
                        width: 80,
                        height: 200,
                        decoration: BoxDecoration(
                          color: COLOR_GREY,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                            onLongPress: () => {},
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => InstanceManager(
                                      data: data,
                                      stream: channel,
                                      wled: wled)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: Column(
                                children: [
                                  addVerticalSpace(10),
                                  Text(
                                    "${data['name']}",
                                  ),
                                  addVerticalSpace(10),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: FlutterSwitch(
                                          value: wled.state.on,
                                          borderRadius: 30.0,
                                          padding: 8.0,
                                          onToggle: (val) {
                                            if ((DateTime.now()
                                                        .millisecondsSinceEpoch) -
                                                    time >
                                                100) {
                                              time = DateTime.now()
                                                  .millisecondsSinceEpoch;
                                              WebsocketHandler().sinkWebsocket(
                                                  channel[1],
                                                  jsonEncode({"on": val}));
                                            }
                                          })),
                                ],
                              ),
                            )));
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return SizedBox(
                width: size.width / 2,
                height: size.height / 2,
                child: const Center(
                  child: CircularProgressIndicator(),
                ));
          },
        ));
  }
}
