import 'package:flutter/material.dart';

class InstanceBottom extends StatefulWidget {
  const InstanceBottom({Key? key, required this.data}) : super(key: key);

  final dynamic data;
  @override
  State<InstanceBottom> createState() => _InstanceBottomState();
}

class _InstanceBottomState extends State<InstanceBottom> {
  dynamic data;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
          label: 'Palettes', //TODO maybe under color wheel to scroll?
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
          backgroundColor: Colors.black,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      onTap: _onItemTapped,
    );
  }
}
