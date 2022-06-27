// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:wledm/utils/constants.dart';

class OptionButton extends StatelessWidget {
  final String text;
  final double width;
  final dynamic onTap;

  final Color color;

  const OptionButton(
      {Key? key,
      required this.text,
      required this.width,
      required this.onTap,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: FlatButton(
          color: color,
          splashColor: Colors.white.withAlpha(55),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(color: COLOR_WHITE),
          )),
    );
  }
}
