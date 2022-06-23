import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:wledm/custom/WLED.dart';
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
      height: size.height,
      child: Column(
        children: [
          ColorPicker(
              paletteType: PaletteType.hueWheel,
              pickerColor: Color.fromARGB(
                  255,
                  wled.state.seg[0]['col'][0][0],
                  wled.state.seg[0]['col'][0][1],
                  wled.state.seg[0]['col'][0][2]),
              enableAlpha: false,
              onColorChanged: (color) {
                if ((DateTime.now().millisecondsSinceEpoch) - time > 100) {
                  time = DateTime.now().millisecondsSinceEpoch;
                  channel.sink.add(jsonEncode({
                    "seg": [
                      {
                        "col": [
                          [color.red, color.green, color.blue]
                        ]
                      }
                    ]
                  }));
                }
              }),
          addVerticalSpace(10),
          StatefulBuilder(builder: (context, state) {
            return Slider(
                value: wled.state.bri.toDouble(),
                min: 0,
                max: 255,
                divisions: 255,
                onChanged: (double value) {
                  wled.state.bri = value.toInt();
                  state(() {});
                  if ((DateTime.now().millisecondsSinceEpoch) - time > 100) {
                    time = DateTime.now().millisecondsSinceEpoch;
                    channel.sink.add(jsonEncode({"bri": value.toInt()}));
                  }
                });
          }),
          addVerticalSpace(10),
          Text(wled.state.toString()),
        ],
      ),
    );
  }
}
