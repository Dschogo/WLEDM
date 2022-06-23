// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:wledm/utils/Preferences.dart';

class SettingsSite extends StatefulWidget {
  const SettingsSite({Key? key}) : super(key: key);

  @override
  State<SettingsSite> createState() => _SettingsSiteState();
}

class _SettingsSiteState extends State<SettingsSite> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: Preferences().somejsonshit.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 50,
                    child: Center(
                        child: Text(
                            'Entry ${Preferences().somejsonshit[index]['name']}')),
                  );
                })));
  }
}
