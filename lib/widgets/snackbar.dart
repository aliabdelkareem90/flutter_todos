import 'package:flutter/material.dart';

showSnackBar({String msg, BuildContext context}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 3),
    ),
  );
}
