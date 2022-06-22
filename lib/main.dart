import 'package:flutter/material.dart';
import 'package:wledm/Screens/SettingsSite.dart';
import 'package:wledm/custom/BorderIcon.dart';
import 'package:wledm/utils/constants.dart';
import 'package:wledm/utils/widget_functions.dart';
import 'package:wledm/Screens/InstanceManager.dart';
import 'package:wledm/utils/preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Preferences().asyncgetSettings();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
                              builder: (context) => const SettingsSite()));
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
                      )
                    ],
                  ),
                ),
                addVerticalSpace(20),
                Padding(
                  padding: sidePadding,
                  child: Text(
                    "WLEDM",
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: ["1", "2", "3", "4"]
                        .map((filter) => ChoiceOption(text: filter))
                        .toList(),
                  ),
                ),
                addVerticalSpace(120),
                Positioned(
                  left: 50,
                  child: SizedBox(
                    width: 380,
                    height: 380,
                    child: GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 6.0,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      children: Preferences()
                          .somejsonshit
                          .map(
                            (item) => Container(
                                margin:
                                    const EdgeInsets.only(left: 10, top: 10),
                                width: 80,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: COLOR_GREY,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: InkWell(
                                    onLongPress: () => {},
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InstanceManager(
                                                    data: item,
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 1),
                                      child: Column(
                                        children: [
                                          addVerticalSpace(10),
                                          Text(
                                            "${item['name']}",
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Switch(
                                              value: false,
                                              onChanged: (value) {},
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))),
                          )
                          .toList(),
                    ),
                  ),
                ),
                addVerticalSpace(20),
                // FutureBuilder(
                //   future: _futurehttp,
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       return Text(snapshot.data.toString());
                //     } else if (snapshot.hasError) {
                //       return Text("${snapshot.error}");
                //     }
                //     return const CircularProgressIndicator();
                //   },
                // )
              ],
            ),
          ],
        ),
      )),
    );
  }
}

class ChoiceOption extends StatelessWidget {
  final String text;

  const ChoiceOption({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: COLOR_GREY.withAlpha(25),
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      margin: const EdgeInsets.only(left: 20),
      child: Text(
        text,
        style: themeData.textTheme.headline5,
      ),
    );
  }
}
