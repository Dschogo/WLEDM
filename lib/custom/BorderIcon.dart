// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:wledm/utils/constants.dart';

class BorderIcon extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double width, height;

  const BorderIcon(
      {Key? key,
      required this.child,
      required this.padding,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: COLOR_WHITE,
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            border: Border.all(color: COLOR_GREY.withAlpha(40), width: 2)),
        padding: padding,
        child: Center(child: child));
  }
}
