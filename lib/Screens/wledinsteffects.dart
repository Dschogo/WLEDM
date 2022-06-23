import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wledm/Widgets/colorpicker.dart';
import 'package:wledm/Widgets/mainMenuInstance.dart';
import 'package:wledm/custom/WLED.dart';
import 'package:wledm/utils/Websockethandler.dart';
import 'package:wledm/utils/constants.dart';
import 'package:wledm/utils/widget_functions.dart';
import 'package:wledm/Screens/nativecontrolsite.dart';
import 'package:wledm/custom/BorderIcon.dart';

class wledinsteffects extends StatefulWidget {
  const wledinsteffects(
      {Key? key, required this.data, required this.stream, required this.wled})
      : super(key: key);

  final dynamic data;
  final dynamic stream;
  final WLED wled;

  @override
  State<wledinsteffects> createState() => _wledinsteffectsState();
}

class _wledinsteffectsState extends State<wledinsteffects> {
  dynamic data;
  dynamic channel;
  late Future<WLED> wledfuture;
  late WLED wled;

  var time = DateTime.now().millisecondsSinceEpoch;

  PageController pagecontroller = PageController(initialPage: 0);

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
    final ThemeData themeData = Theme.of(context);

    return SizedBox(
        width: size.width,
        height: size.height,
        child: StreamBuilder(
            stream: channel[0],
            builder: (context, streamsnapshot) {
              if (streamsnapshot.hasData) {
                wled = wled.update(jsonDecode(streamsnapshot.data as String));
              }
              return GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 6.0,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                children: wled.effectPalette.effects
                    .map(
                      (e) => InkWell(
                          onTap: () {
                            if ((DateTime.now().millisecondsSinceEpoch) - time >
                                100) {
                              time = DateTime.now().millisecondsSinceEpoch;
                              WebsocketHandler().sinkWebsocket(
                                  channel[1],
                                  jsonEncode({
                                    "seg": [
                                      {
                                        "fx": e[1],
                                      }
                                    ]
                                  }));
                            }
                          },
                          child: Text(
                              '${e[0]} - ${e[1] == wled.state.seg[0]['fx'] ? '✅' : e[1]}')),
                    )
                    .toList(),
              );
            }));
  }
}
