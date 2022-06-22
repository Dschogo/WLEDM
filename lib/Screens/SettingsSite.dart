import 'package:flutter/material.dart';
import 'package:wledm/custom/BorderIcon.dart';
import 'package:wledm/utils/Preferences.dart';
import 'package:wledm/utils/constants.dart';
import 'package:wledm/utils/widget_functions.dart';

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
