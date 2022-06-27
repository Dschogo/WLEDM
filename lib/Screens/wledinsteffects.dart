// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wledm/custom/OptionButton.dart';
import 'package:wledm/custom/WLED.dart';
import 'package:wledm/utils/Websockethandler.dart';
import 'package:wledm/utils/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
  bool ispressed = false;
  bool ispressed2 = false;

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

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Effects'),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: StreamBuilder(
          stream: channel[0],
          builder: (context, streamsnapshot) {
            if (streamsnapshot.hasData) {
              wled = wled.update(jsonDecode(streamsnapshot.data as String));
            }
            return SizedBox(
                height: size.height * 0.15,
                width: size.width * 0.85,
                child: Row(children: [
                  StatefulBuilder(builder: (context, setState) {
                    return GestureDetector(
                      onLongPressStart: (details) {
                        ispressed = true;
                        setState(() {});
                      },
                      onLongPressEnd: (details) {
                        ispressed = false;
                        setState(() {});
                      },
                      onLongPressMoveUpdate: (details) {
                        int x = wled.state.seg[0]['sx'] -
                            details.offsetFromOrigin.dy ~/ 4;
                        if (x < 0) {
                          x = 0;
                        } else if (x > 255) {
                          x = 255;
                        }
                        if ((DateTime.now().millisecondsSinceEpoch) - time >
                            100) {
                          time = DateTime.now().millisecondsSinceEpoch;

                          WebsocketHandler().sinkWebsocket(
                              channel[1],
                              jsonEncode({
                                "seg": [
                                  {
                                    "ix": x,
                                  }
                                ]
                              }));
                        }
                        setState(() {
                          wled.state.seg[0]['ix'] = x;
                        });
                      },
                      child: SizedBox(
                          width: size.width * 0.3,
                          height: size.width * 0.2,
                          child: Center(
                              child: RotatedBox(
                                  quarterTurns: 3,
                                  child: LinearPercentIndicator(
                                    center: RotatedBox(
                                        quarterTurns: 1,
                                        child: Text(wled.state.seg[0]['ix']
                                            .toString())),
                                    lineHeight: ispressed ? 60 : 54.0,
                                    animateFromLastPercent: true,
                                    animation: true,
                                    percent: wled.state.seg[0]['ix'] / 255,
                                    backgroundColor: Color.fromARGB(
                                        122, 122, 122, ispressed ? 255 : 122),
                                    progressColor:
                                        ispressed ? Colors.green : Colors.blue,
                                    barRadius: const Radius.circular(10),
                                  )))),
                    );
                  }),
                  const Spacer(
                    flex: 1,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: size.height * 0.05),
                      child: OptionButton(
                          text: "Solid",
                          width: size.width * 0.2,
                          color: wled.state.seg[0]['fx'] == 0
                              ? Colors.green
                              : COLOR_DARK_BLUE,
                          onTap: () {
                            if ((DateTime.now().millisecondsSinceEpoch) - time >
                                100) {
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
                          })),
                  const Spacer(
                    flex: 1,
                  ),
                  StatefulBuilder(builder: (context, setState) {
                    return GestureDetector(
                      onLongPressStart: (details) {
                        ispressed2 = true;
                        setState(() {});
                      },
                      onLongPressEnd: (details) {
                        ispressed2 = false;
                        setState(() {});
                      },
                      onLongPressMoveUpdate: (details) {
                        int x = wled.state.seg[0]['sx'] -
                            details.offsetFromOrigin.dy ~/ 4;
                        if (x < 0) {
                          x = 0;
                        } else if (x > 255) {
                          x = 255;
                        }
                        if ((DateTime.now().millisecondsSinceEpoch) - time >
                            100) {
                          time = DateTime.now().millisecondsSinceEpoch;

                          WebsocketHandler().sinkWebsocket(
                              channel[1],
                              jsonEncode({
                                "seg": [
                                  {
                                    "sx": x,
                                  }
                                ]
                              }));
                        }
                        setState(() {
                          wled.state.seg[0]['sx'] = x;
                        });
                      },
                      child: SizedBox(
                          width: size.width * 0.3,
                          height: size.width * (ispressed2 ? 0.4 : 0.2),
                          child: Center(
                              child: RotatedBox(
                                  quarterTurns: 3,
                                  child: LinearPercentIndicator(
                                    center: RotatedBox(
                                        quarterTurns: 1,
                                        child: Text(wled.state.seg[0]['sx']
                                            .toString())),
                                    lineHeight: ispressed2 ? 80 : 54.0,
                                    animateFromLastPercent: true,
                                    animation: true,
                                    percent: wled.state.seg[0]['sx'] / 255,
                                    backgroundColor: Color.fromARGB(
                                        122, 122, 122, ispressed2 ? 255 : 122),
                                    progressColor:
                                        ispressed2 ? Colors.green : Colors.blue,
                                    barRadius: const Radius.circular(10),
                                  )))),
                    );
                  }),
                ]));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SizedBox(
          width: size.width,
          height: size.height,
          child: StreamBuilder(
              stream: channel[0],
              builder: (context, streamsnapshot) {
                if (streamsnapshot.hasError) {
                  return Center(
                    child: Text('Error: ${streamsnapshot.error}'),
                  );
                }
                if (streamsnapshot.hasData) {
                  wled = wled.update(jsonDecode(streamsnapshot.data as String));
                }
                return ListView(
                    padding: const EdgeInsets.only(bottom: 70),
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    children: wled.effectPalette.effects
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 25, top: 2, bottom: 2),
                              child: Container(
                                height: size.height * 0.04,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: wled.getGradient(2,
                                        intensity:
                                            (e[1] == wled.state.seg[0]['fx'])
                                                ? 200
                                                : 80),
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
                                                "fx": e[1],
                                              }
                                            ]
                                          }));
                                    }
                                  },
                                  child: Text('${e[0]} - ${e[1]}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        // fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ))
                        .toList());
              })),
    );
  }
}
