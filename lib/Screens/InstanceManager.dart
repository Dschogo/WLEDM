import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:wledm/custom/BorderIcon.dart';
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
  late dynamic data;
  late dynamic channel;
  dynamic initialState = {};
  bool switched = true;

  var time = DateTime.now().millisecondsSinceEpoch;

  Future<dynamic> loadstate(data) async {
    final response =
        await http.get(Uri.parse("http://${data["webadress"]}/json"));

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      dynamic values = json.decode(response.body);

      initialState = values;
      return values;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    super.initState();
    data = widget.data;

    loadstate(data);

    print(data);
    print('initial: $initialState');
    bool switched = true;
    channel = Preferences().getWebsocket(data['webadress']);
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
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(padding),
                Padding(
                  padding: sidePadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NativeControlSite(
                                  webadress: 'http://${data["webadress"]}')));
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${data?['name'] ?? "not found"}",
                          style: themeData.textTheme.headline4,
                        ),
                        Switch(
                            value: switched,
                            onChanged: (boolean) {
                              if ((DateTime.now().millisecondsSinceEpoch) -
                                      time >
                                  100) {
                                time = DateTime.now().millisecondsSinceEpoch;
                                channel.sink.add(jsonEncode({"on": boolean}));
                                setState(() {
                                  switched = !boolean;
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
                    pickerColor: const Color.fromARGB(255, 0, 145, 255),
                    onColorChanged: (color) {
                      if ((DateTime.now().millisecondsSinceEpoch) - time >
                          100) {
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
                StreamBuilder(
                  stream: channel.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                    }
                    return const Text('');
                  },
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
