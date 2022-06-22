import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Widget addVerticalSpace(double height) {
  return SizedBox(height: height);
}

Widget addHorizontalSpace(double width) {
  return SizedBox(width: width);
}

Future<dynamic> fetchData(String server, String path) async {
  final response = await http.get(Uri.parse('http://$server$path'));
  return json.decode(response.body);
}
