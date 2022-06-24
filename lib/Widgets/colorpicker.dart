// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:wledm/custom/WLED.dart';
import 'package:wledm/utils/Websockethandler.dart';
import 'package:wledm/utils/widget_functions.dart';

class Colorpicker extends StatefulWidget {
  const Colorpicker({Key? key, required this.channel, required this.wled})
      : super(key: key);

  final dynamic channel;
  final WLED wled;
  @override
  State<Colorpicker> createState() => _ColorpickerState();
}

class _ColorpickerState extends State<Colorpicker> {
  dynamic channel;
  late WLED wled;
  var time = DateTime.now().millisecondsSinceEpoch;

  int selectedcolor = 0;

  @override
  void initState() {
    super.initState();
    channel = widget.channel;
    wled = widget.wled;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width,
        height: size.height - 240,
        child: StatefulBuilder(builder: (context, state) {
          return Column(
            children: [
              ColorPicker(
                  paletteType: PaletteType.hueWheel,
                  pickerColor: Color.fromARGB(
                      255,
                      wled.state.seg[0]['col'][selectedcolor][0],
                      wled.state.seg[0]['col'][selectedcolor][1],
                      wled.state.seg[0]['col'][selectedcolor][2]),
                  enableAlpha: false,
                  displayThumbColor: true,
                  onColorChanged: (color) {
                    if ((DateTime.now().millisecondsSinceEpoch) - time > 100) {
                      wled.state.seg[0]['col'][selectedcolor][0] = color.red;
                      wled.state.seg[0]['col'][selectedcolor][1] = color.green;
                      wled.state.seg[0]['col'][selectedcolor][2] = color.blue;
                      time = DateTime.now().millisecondsSinceEpoch;
                      WebsocketHandler().sinkWebsocket(
                          channel[1],
                          jsonEncode({
                            "seg": [
                              {
                                "col": [
                                  [
                                    wled.state.seg[0]['col'][0][0],
                                    wled.state.seg[0]['col'][0][1],
                                    wled.state.seg[0]['col'][0][2]
                                  ],
                                  [
                                    wled.state.seg[0]['col'][1][0],
                                    wled.state.seg[0]['col'][1][1],
                                    wled.state.seg[0]['col'][1][2]
                                  ],
                                  [
                                    wled.state.seg[0]['col'][2][0],
                                    wled.state.seg[0]['col'][2][1],
                                    wled.state.seg[0]['col'][2][2]
                                  ],
                                ]
                              }
                            ]
                          }));
                    }
                  }),
              Slider(
                  value: wled.state.bri.toDouble(),
                  min: 0,
                  max: 255,
                  divisions: 255,
                  onChanged: (double value) {
                    state(() {});
                    wled.state.bri = value.toInt();
                    if ((DateTime.now().millisecondsSinceEpoch) - time > 100) {
                      time = DateTime.now().millisecondsSinceEpoch;
                      WebsocketHandler().sinkWebsocket(
                          channel[1], jsonEncode({"bri": value.toInt()}));
                    }
                  }),
              addVerticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: () {
                        selectedcolor = 0;
                        state(() {});
                      },
                      customBorder: const CircleBorder(
                          side: BorderSide(color: Colors.black, width: 6)),
                      child: AnimatedContainer(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: selectedcolor == 0
                              ? Border.all(color: Colors.blueAccent, width: 4)
                              : null,
                          color: Color.fromARGB(
                              255,
                              wled.state.seg[0]['col'][0][0],
                              wled.state.seg[0]['col'][0][1],
                              wled.state.seg[0]['col'][0][2]),
                        ),
                        duration: const Duration(milliseconds: 300),
                      )),
                  InkWell(
                      onTap: () {
                        selectedcolor = 1;
                        state(() {});
                      },
                      customBorder: const CircleBorder(
                          side: BorderSide(color: Colors.black, width: 6)),
                      child: AnimatedContainer(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: selectedcolor == 1
                              ? Border.all(color: Colors.blueAccent, width: 4)
                              : null,
                          color: Color.fromARGB(
                              255,
                              wled.state.seg[0]['col'][1][0],
                              wled.state.seg[0]['col'][1][1],
                              wled.state.seg[0]['col'][1][2]),
                        ),
                        duration: const Duration(milliseconds: 300),
                      )),
                  InkWell(
                      onTap: () {
                        selectedcolor = 2;
                        state(() {});
                      },
                      customBorder: const CircleBorder(
                          side: BorderSide(color: Colors.black, width: 6)),
                      child: AnimatedContainer(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: selectedcolor == 2
                              ? Border.all(color: Colors.blueAccent, width: 4)
                              : null,
                          color: Color.fromARGB(
                              255,
                              wled.state.seg[0]['col'][2][0],
                              wled.state.seg[0]['col'][2][1],
                              wled.state.seg[0]['col'][2][2]),
                        ),
                        duration: const Duration(milliseconds: 300),
                      )),
                ],
              )
              //Text(wled.state.toString()),
            ],
          );
        }));
  }
}
