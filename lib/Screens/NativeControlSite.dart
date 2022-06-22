import 'package:flutter/material.dart';
import 'package:wledm/custom/BorderIcon.dart';
import 'package:wledm/utils/constants.dart';
import 'package:wledm/utils/constants.dart';
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
