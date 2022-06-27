// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:wledm/Widgets/colorpicker.dart';
import 'package:wledm/custom/WLED.dart';
import 'package:wledm/utils/Websockethandler.dart';
import 'package:wledm/utils/constants.dart';
import 'package:wledm/utils/widget_functions.dart';
import 'package:wledm/Screens/nativecontrolsite.dart';
import 'package:wledm/custom/BorderIcon.dart';

class wledinsthome extends StatefulWidget {
  const wledinsthome(
      {Key? key, required this.data, required this.stream, required this.wled})
      : super(key: key);

  final dynamic data;
  final dynamic stream;
  final WLED wled;

  @override
  State<wledinsthome> createState() => _wledinsthomeState();
}

class _wledinsthomeState extends State<wledinsthome> {
  dynamic data;
  dynamic channel;
  late Future<WLED> wledfuture;
  late WLED wled;

  var time = DateTime.now().millisecondsSinceEpoch;

  @override
  void initState() {
    super.initState();
    data = widget.data;
    channel = widget.stream;
    wled = widget.wled;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: StreamBuilder(
            stream: channel[0],
            builder: (context, streamsnapshot) {
              if (streamsnapshot.hasData) {
                wled = wled.update(jsonDecode(streamsnapshot.data as String));
              }
              return Stack(
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    addVerticalSpace(padding),
                    Padding(
                      padding: sidePadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NativeControlSite(
                                      webadress:
                                          'http://${data["webadress"]}')));
                            },
                            child: const BorderIcon(
                              height: 50,
                              width: 50,
                              padding: EdgeInsets.all(1),
                              child: Icon(
                                Icons.settings,
                                color: COLOR_BLACK,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    addVerticalSpace(10),
                    Padding(
                      padding: sidePadding,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${data?['name'] ?? "not found"}",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            FlutterSwitch(
                              width: 105,
                              value: wled.state.udpnsend,
                              borderRadius: 30.0,
                              padding: 8.0,
                              activeText: 'Sync',
                              inactiveText: 'no Sync',
                              showOnOff: true,
                              onToggle: (val) {
                                setState(() {});
                                if ((DateTime.now().millisecondsSinceEpoch) -
                                        time >
                                    100) {
                                  time = DateTime.now().millisecondsSinceEpoch;
                                  WebsocketHandler().sinkWebsocket(
                                      channel[1],
                                      jsonEncode({
                                        "udpn": {
                                          "send": val,
                                          "recv": val,
                                        }
                                      }));
                                }
                              },
                            ),
                            FlutterSwitch(
                              value: wled.state.on,
                              borderRadius: 30.0,
                              padding: 8.0,
                              showOnOff: true,
                              onToggle: (val) {
                                setState(() {});
                                if ((DateTime.now().millisecondsSinceEpoch) -
                                        time >
                                    100) {
                                  time = DateTime.now().millisecondsSinceEpoch;
                                  WebsocketHandler().sinkWebsocket(
                                      channel[1], jsonEncode({"on": val}));
                                }
                              },
                            ),
                          ]),
                    ),
                    Padding(
                        padding: sidePadding,
                        child: const Divider(
                          height: 25,
                          color: COLOR_GREY,
                        )),
                    Colorpicker(channel: channel, wled: wled),
                  ]),
                ],
              );
            }),
      ),
    );
  }
}
