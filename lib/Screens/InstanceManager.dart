import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:wledm/custom/BorderIcon.dart';
import 'package:wledm/utils/constants.dart';
import 'package:wledm/utils/preferences.dart';
import 'package:wledm/utils/widget_functions.dart';
import 'package:wledm/Screens/NativeControlSite.dart';

class InstanceManager extends StatefulWidget {
  const InstanceManager({Key? key, required this.data}) : super(key: key);

  final dynamic data;

  @override
  State<InstanceManager> createState() => _InstanceManagerState();
}

class _InstanceManagerState extends State<InstanceManager> {
  late dynamic data;
  late dynamic channel;

  @override
  void initState() {
    super.initState();
    data = widget.data;
    print(data);
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
                  child: Text(
                    "${data?['name'] ?? "not found"}",
                    style: themeData.textTheme.headline4,
                  ),
                ),
                Padding(
                    padding: sidePadding,
                    child: const Divider(
                      height: 25,
                      color: COLOR_GREY,
                    )),
                addVerticalSpace(10),
                StreamBuilder(
                  stream: channel.stream,
                  builder: (context, snapshot) {
                    return Text(snapshot.hasData ? '${snapshot.data}' : '');
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
