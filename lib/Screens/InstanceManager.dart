// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:wledm/Screens/wledinsteffects.dart';
import 'package:wledm/Screens/wledinsthome.dart';
import 'package:wledm/Screens/wledinstpalettes.dart';
import 'package:wledm/custom/WLED.dart';

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

  PageController pagecontroller = PageController(initialPage: 0);

  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      pagecontroller.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  void initState() {
    super.initState();
    data = widget.data;
    channel = widget.stream;
    wled = widget.wled;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: PageView(
                controller: pagecontroller,
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                children: [
                  wledinsthome(data: data, stream: channel, wled: wled),
                  wledinsteffects(data: data, stream: channel, wled: wled),
                  wledinstpalettes(data: data, stream: channel, wled: wled),
                  Container(
                    color: Colors.grey,
                  ),
                ]),
            bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                    backgroundColor: Colors.black,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.business),
                    label: 'Effects',
                    backgroundColor: Colors.black,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.school),
                    label: 'Palettes',
                    backgroundColor: Colors.black,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                    backgroundColor: Colors.black,
                  ),
                ],
                currentIndex: selectedIndex,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white70,
                onTap: _onItemTapped)));
  }
}
