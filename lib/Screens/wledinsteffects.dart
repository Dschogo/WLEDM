import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wledm/Widgets/colorpicker.dart';
import 'package:wledm/Widgets/mainMenuInstance.dart';
import 'package:wledm/custom/OptionButton.dart';
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

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Effects'),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: StreamBuilder(
          stream: channel[0],
          builder: (context, streamsnapshot) {
            return OptionButton(
              text: "Solid",
              width: size.width * 0.3,
              color:
                  wled.state.seg[0]['fx'] == 0 ? Colors.green : COLOR_DARK_BLUE,
              onTap: () {
                if ((DateTime.now().millisecondsSinceEpoch) - time > 100) {
                  time = DateTime.now().millisecondsSinceEpoch;
                  WebsocketHandler().sinkWebsocket(
                      channel[1],
                      jsonEncode({
                        "seg": [
                          {
                            "fx": '0',
                          }
                        ]
                      }));
                }
              },
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SizedBox(
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
                  mainAxisSpacing: 2.0,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  children: wled.effectPalette.effects
                      .map((e) => ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: InkWell(
                              onTap: () {
                                setState(() {});
                                if ((DateTime.now().millisecondsSinceEpoch) -
                                        time >
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
                              child: Stack(children: [
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors:
                                            (e[1] == wled.state.seg[0]['fx'])
                                                ? const [
                                                    Color.fromARGB(
                                                        255, 13, 161, 70),
                                                    Color.fromARGB(
                                                        255, 124, 210, 25),
                                                    Color.fromARGB(
                                                        255, 199, 248, 108),
                                                  ]
                                                : const [
                                                    Color(0xFF0D47A1),
                                                    Color(0xFF1976D2),
                                                    Color(0xFF42A5F5),
                                                  ],
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.all(5.0),
                                      primary: Colors.white,
                                      textStyle: const TextStyle(fontSize: 15),
                                    ),
                                    onPressed: null,
                                    child: Text(
                                        '${e[0]} - ${e[1] == wled.state.seg[0]['fx'] ? '✅' : e[1]}',
                                        style: const TextStyle(
                                            color: Colors.white))),
                              ]))))
                      .toList(),
                );
              })),
    );
  }
}
