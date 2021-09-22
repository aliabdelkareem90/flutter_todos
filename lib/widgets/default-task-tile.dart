import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_todo_app/cubit/app-cubit.dart';
import 'package:flutter_todo_app/widgets/snackbar.dart';

Widget defaultTaskTile(BuildContext context, Map map) {
  List<MaterialColor> colors = [
    Colors.red,
    Colors.orange,
    Colors.green,
  ];

  return Slidable(
    actionPane: SlidableDrawerActionPane(),
    actions: <Widget>[
      IconSlideAction(
        caption: 'Done',
        color: Colors.green,
        icon: Icons.done,
        onTap: () {
          AppCubit.get(context).updateData(status: 'done', id: map['id']);
          showSnackBar(context: context, msg: 'Task has been done');
        },
      ),
      IconSlideAction(
        caption: 'Archive',
        color: Colors.blueAccent,
        icon: Icons.archive,
        onTap: () {
          AppCubit.get(context).updateData(status: 'archived', id: map['id']);
          showSnackBar(context: context, msg: 'Task has been archived');
        },
      ),
    ],
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: 'Delete',
        color: Colors.redAccent,
        icon: Icons.delete,
        onTap: () {
          AppCubit.get(context).deleteData(id: map['id']);
          showSnackBar(context: context, msg: 'Task has been deleted');
        },
      ),
    ],
    child: Container(
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 10.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    color: colors[Random().nextInt(colors.length)],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                  )
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${map['title']}',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${map['desc']}',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black45
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${map['time']}',
                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                  Text(
                    '${map['date']}',
                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
