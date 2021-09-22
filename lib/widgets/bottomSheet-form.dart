import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'defaultTextFormField.dart';

Widget bottomSheetForm({
  @required BuildContext context,
  @required GlobalKey<FormState> formKey,
  @required TextEditingController titleController,
  @required TextEditingController descController,
  @required TextEditingController timeController,
  @required TextEditingController dateController,
}) {

  return Form(
    key: formKey,
    child: Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultTextFormField(
            controller: titleController,
            label: 'Task Title',
            iconData: Icons.title,
            type: TextInputType.text,
            onSubmitted: (String value) {
              titleController.text = value;
            },
            validate: (String value) {
              if (value.isEmpty) {
                return 'Title is required';
              }
              return null;
            },
          ),
          SizedBox(
            height: 15.0,
          ),
          DefaultTextFormField(
            controller: descController,
            label: 'Task Description',
            iconData: Icons.description_outlined,
            type: TextInputType.text,
            maxLength: 30,
            onSubmitted: (String value) {
              titleController.text = value;
            },
            validate: (String value) {
              if (value.isEmpty) {
                return 'Description is required';
              }
              return null;
            },
          ),
          SizedBox(
            height: 15.0,
          ),
          DefaultTextFormField(
            controller: timeController,
            label: 'Task Time',
            iconData: Icons.watch_later_outlined,
            type: TextInputType.datetime,
            onTap: () {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              ).then((value) {
                timeController.text = value.format(context).toString();
              });
            },
            validate: (String value) {
              if (value.isEmpty) {
                return 'Time is required';
              }
              return null;
            },
          ),
          SizedBox(
            height: 15.0,
          ),
          DefaultTextFormField(
            controller: dateController,
            label: 'Task Date',
            iconData: Icons.calendar_today_outlined,
            type: TextInputType.datetime,
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.parse('2030-12-31'),
              ).then(
                (value) {
                  dateController.text = DateFormat.yMMMd().format(value);
                  // print(dateController.text);
                },
              );
            },
            validate: (String value) {
              if (value.isEmpty) {
                return 'Date is required';
              }
              return null;
            },
          ),
        ],
      ),
    ),
  );
}
