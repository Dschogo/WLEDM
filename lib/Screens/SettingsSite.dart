// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:wledm/utils/SettingsHandler.dart';
import 'package:wledm/utils/Websockethandler.dart';

class SettingsSite extends StatefulWidget {
  const SettingsSite({Key? key}) : super(key: key);

  @override
  State<SettingsSite> createState() => _SettingsSiteState();
}

class _SettingsSiteState extends State<SettingsSite> {
  late TextEditingController controllername;
  late TextEditingController controlleradress;

  @override
  void initState() {
    super.initState();
    controllername = TextEditingController();
    controlleradress = TextEditingController();
  }

  @override
  void dispose() {
    controllername.dispose();
    controlleradress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(
              title: const Text('Instance Settings'),
              backgroundColor: Colors.black,
            ),
            body: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                    width: size.width,
                    height: 500,
                    child: Column(children: [
                      ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: SettingsHandler().getSettings().length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                SizedBox(
                                    height: 50,
                                    width: size.width * 0.9,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              '${SettingsHandler().getSettings()[index]['name']}'),
                                          Icon(
                                            WebsocketHandler().isWSconnected(
                                                    SettingsHandler()
                                                            .getSettings()[
                                                        index]['webadress'])
                                                ? Icons.check_circle
                                                : Icons.error,
                                            color: Colors.black,
                                          ),
                                          ElevatedButton(
                                              onPressed: (() {
                                                SettingsHandler().delteInstance(
                                                    SettingsHandler()
                                                            .getSettings()[
                                                        index]['webadress']);
                                                setState(() {});
                                              }),
                                              child: const Text('remove'))
                                        ],
                                      ),
                                    )),
                              ],
                            );
                          }),
                      ElevatedButton(
                          onPressed: () {
                            openDialog();
                          },
                          child: const Text(
                            'add wled',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    ])))));
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('Add Entry'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controllername,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextField(
                  controller: controlleradress,
                  decoration: const InputDecoration(
                    labelText: 'ip (without http://)',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('cancel')),
              TextButton(
                  onPressed: () {
                    SettingsHandler().addInstance(
                        controllername.text, controlleradress.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text('add')),
            ]),
      );
}
