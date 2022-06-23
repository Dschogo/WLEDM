// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wledm/Screens/colorpicker.dart';
import 'package:wledm/Widgets/bottomnavbar.dart';
import 'package:wledm/custom/bordericon.dart';
import 'package:wledm/custom/WLED.dart';
import 'package:wledm/utils/Websockethandler.dart';
import 'package:wledm/utils/constants.dart';
import 'package:wledm/utils/widget_functions.dart';
import 'package:wledm/Screens/nativecontrolsite.dart';
import 'package:http/http.dart' as http;

class InstanceManager extends StatefulWidget {
  const InstanceManager(
      {Key? key, required this.data, required this.stream, required this.wled})
      : super(key: key);

  final dynamic data;
  final dynamic stream;
  final WLED wled;

  @override
  State<InstanceManager> createState() => _InstanceManagerState();
}

class _InstanceManagerState extends State<InstanceManager> {
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
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
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
                                style: themeData.textTheme.headline6,
                              ),
                              Switch(
                                  value: wled.state.on,
                                  onChanged: (boolean) {
                                    if ((DateTime.now()
                                                .millisecondsSinceEpoch) -
                                            time >
                                        100) {
                                      time =
                                          DateTime.now().millisecondsSinceEpoch;
                                      WebsocketHandler().sinkWebsocket(
                                          channel[1],
                                          jsonEncode({"on": boolean}));
                                    }
                                  })
                            ]),
                      ),
                      Padding(
                          padding: sidePadding,
                          child: const Divider(
                            height: 25,
                            color: COLOR_GREY,
                          )),
                      Colorpicker(channel: channel, wled: wled),
                      // PageView(
                      //   controller: pageController,
                      //   scrollDirection: Axis.horizontal,
                      //   onPageChanged: (index) {},
                      //   children: [

                      //     Colorpicker(channel: channel, wled: wled),
                      //     Colorpicker(channel: channel, wled: wled),
                      //     Colorpicker(channel: channel, wled: wled),
                      //   ],
                      // )
                    ],
                  ),
                ],
              );
            }),
      ),
      bottomNavigationBar: InstanceBottom(data: data),
    ));
  }
}
