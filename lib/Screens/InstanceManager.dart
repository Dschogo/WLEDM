import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:wledm/custom/BorderIcon.dart';
import 'package:wledm/custom/WLED.dart';
import 'package:wledm/utils/constants.dart';
import 'package:wledm/utils/preferences.dart';
import 'package:wledm/utils/widget_functions.dart';
import 'package:wledm/Screens/NativeControlSite.dart';
import 'package:http/http.dart' as http;

class InstanceManager extends StatefulWidget {
  const InstanceManager({Key? key, required this.data}) : super(key: key);

  final dynamic data;

  @override
  State<InstanceManager> createState() => _InstanceManagerState();
}

class _InstanceManagerState extends State<InstanceManager> {
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
    channel = Preferences().getWebsocket(data['webadress']);
    wledfuture = loadstate(data);
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
          child: FutureBuilder<WLED>(
            future: wledfuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                wled = snapshot.data!;
                return StreamBuilder(
                    stream: channel.stream,
                    builder: (context, streamsnapshot) {
                      if (streamsnapshot.hasData) {
                        wled = wled
                            .update(jsonDecode(streamsnapshot.data as String));
                      }
                      print(wled.state.toString());
                      return Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              addVerticalSpace(padding),
                              Padding(
                                padding: sidePadding,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const BorderIcon(
                                      height: 50,
                                      width: 50,
                                      padding: EdgeInsets.all(1),
                                      child: Icon(
                                        Icons.menu,
                                        color: COLOR_BLACK,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NativeControlSite(
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
                              addVerticalSpace(20),
                              Padding(
                                padding: sidePadding,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${data?['name'] ?? "not found"}",
                                        style: themeData.textTheme.headline4,
                                      ),
                                      Switch(
                                          value: wled.state.on,
                                          onChanged: (boolean) {
                                            if ((DateTime.now()
                                                        .millisecondsSinceEpoch) -
                                                    time >
                                                100) {
                                              time = DateTime.now()
                                                  .millisecondsSinceEpoch;
                                              channel.sink.add(
                                                  jsonEncode({"on": boolean}));
                                              setState(() {
                                                wled.state.on = boolean;
                                              });
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
                              addVerticalSpace(10),
                              HueRingPicker(
                                  pickerColor:
                                      const Color.fromARGB(255, 0, 145, 255),
                                  onColorChanged: (color) {
                                    if ((DateTime.now()
                                                .millisecondsSinceEpoch) -
                                            time >
                                        100) {
                                      time =
                                          DateTime.now().millisecondsSinceEpoch;
                                      channel.sink.add(jsonEncode({
                                        "seg": [
                                          {
                                            "col": [
                                              [
                                                color.red,
                                                color.green,
                                                color.blue
                                              ]
                                            ]
                                          }
                                        ]
                                      }));
                                    }
                                  }),
                              addVerticalSpace(10),
                              Slider(
                                  value: wled.state.bri.toDouble(),
                                  min: 0,
                                  max: 255,
                                  divisions: 255,
                                  onChanged: (value) {
                                    if ((DateTime.now()
                                                .millisecondsSinceEpoch) -
                                            time >
                                        100) {
                                      time =
                                          DateTime.now().millisecondsSinceEpoch;
                                      channel.sink
                                          .add(jsonEncode({"bri": value}));
                                      // setState(() {
                                      //   print(value);
                                      //   wled.state.bri = value.toInt();
                                      // });
                                    }
                                  }),
                              addVerticalSpace(10),
                            ],
                          ),
                        ],
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          )),
    ));
  }
}
