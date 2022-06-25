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

class wledinstpalettes extends StatefulWidget {
  const wledinstpalettes(
      {Key? key, required this.data, required this.stream, required this.wled})
      : super(key: key);

  final dynamic data;
  final dynamic stream;
  final WLED wled;

  @override
  State<wledinstpalettes> createState() => _wledinstpalettesState();
}

class _wledinstpalettesState extends State<wledinstpalettes> {
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
        title: const Text('palettes'),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: StreamBuilder(
          stream: channel[0],
          builder: (context, streamsnapshot) {
            return OptionButton(
              text: "Default",
              width: size.width * 0.3,
              color: wled.state.seg[0]['pal'] == 0
                  ? Colors.green
                  : COLOR_DARK_BLUE,
              onTap: () {
                if ((DateTime.now().millisecondsSinceEpoch) - time > 100) {
                  time = DateTime.now().millisecondsSinceEpoch;
                  WebsocketHandler().sinkWebsocket(
                      channel[1],
                      jsonEncode({
                        "seg": [
                          {
                            "pal": '0',
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
                return ListView(
                    padding: const EdgeInsets.only(bottom: 70),
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    children: wled.effectPalette.palettes
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 25, top: 2, bottom: 2),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: wled.getGradient(e[1]),
                                  ),
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    elevation: MaterialStateProperty.all(0),
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                  ),
                                  onPressed: () {
                                    setState(() {});
                                    if ((DateTime.now()
                                                .millisecondsSinceEpoch) -
                                            time >
                                        100) {
                                      time =
                                          DateTime.now().millisecondsSinceEpoch;
                                      WebsocketHandler().sinkWebsocket(
                                          channel[1],
                                          jsonEncode({
                                            "seg": [
                                              {
                                                "pal": e[1],
                                              }
                                            ]
                                          }));
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    child: Text(
                                      '${e[0]} - ${e[1] == wled.state.seg[0]['pal'] ? '${e[1]}✅' : e[1]}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        // fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList());
              })),
    );
  }
}
