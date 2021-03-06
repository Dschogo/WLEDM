// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NativeControlSite extends StatelessWidget {
  final dynamic webadress;

  const NativeControlSite({Key? key, required this.webadress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: webadress,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
