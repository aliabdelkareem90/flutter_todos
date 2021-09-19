import 'package:flutter/material.dart';

Widget backgroundContainer(BuildContext context, String title) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.topRight,
        colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).accentColor,
        ],
      ),
    ),
    child: Column(
      children: [
        SizedBox(
          height: 70.0,
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          TimeOfDay.now().format(context),
          style: TextStyle(
            color: Colors.white,
            fontSize: 50.0,
          ),
        ),
      ],
    ),
  );
}
