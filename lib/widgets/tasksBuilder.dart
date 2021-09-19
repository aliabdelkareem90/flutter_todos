import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'background-container.dart';
import 'default-task-tile.dart';

Widget tasksBuilder({
  BuildContext context,
  String tasksType,
  String nullMsg,
  List<Map> tasks,
}) {
  return Stack(
    children: [
      backgroundContainer(context, tasksType),
      Container(
        margin: EdgeInsets.only(top: 240),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: ConditionalBuilder(
          condition: tasks.length > 0,
          fallback: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.list_rounded,
                  size: 100,
                  color: Colors.black45,
                ),
                Text(
                  nullMsg,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ListView.separated(
                itemCount: tasks.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  height: 3.0,
                ),
                itemBuilder: (BuildContext context, int index) =>
                    defaultTaskTile(context, tasks[index]),
              ),
            );
          },
        ),
      )
    ],
  );
}
