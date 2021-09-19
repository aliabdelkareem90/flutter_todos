import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/cubit/app-cubit.dart';
import 'package:flutter_todo_app/cubit/app-states.dart';
import 'package:flutter_todo_app/widgets/defaultTextFormField.dart';
import 'package:intl/intl.dart';

class HomeLayout extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is InsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit appCubit = AppCubit.get(context);
          return Scaffold(
            key: _scaffoldKey,
            body: appCubit.screens[appCubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              currentIndex: appCubit.currentIndex,
              onTap: (index) {
                appCubit.changeBottomNavBarState(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.notes),
                  label: 'New',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive),
                  label: 'Archived',
                ),
              ],
              selectedItemColor: Theme.of(context).primaryColor,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
              selectedIconTheme: IconThemeData(size: 30),
              unselectedItemColor: Colors.blueGrey[300],
              elevation: 10.0,
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(appCubit.fabIcon),
              backgroundColor: Theme.of(context).accentColor,
              onPressed: () async {
                if (appCubit.isBottomSheetShown) {
                  if (_formKey.currentState.validate()) {
                    appCubit
                        .insertToDatabase(
                      date: dateController.text,
                      time: timeController.text,
                      title: titleController.text,
                    )
                        .then(
                      (value) {
                        appCubit.changeBottomSheetState(
                          isShown: false,
                          iconData: Icons.edit,
                        );
                      },
                    );
                    titleController.text = '';
                    timeController.text = '';
                    dateController.text = '';
                  }
                } else {
                  _scaffoldKey.currentState
                      .showBottomSheet(
                        (context) => Form(
                          key: _formKey,
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
                                  controller: timeController,
                                  label: 'Task Time',
                                  iconData: Icons.watch_later_outlined,
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value.format(context).toString();
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
                                        dateController.text =
                                            DateFormat.yMMMd().format(value);
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
                        ),
                        elevation: 10.0,
                      )
                      .closed
                      .then(
                    (value) {
                      appCubit.changeBottomSheetState(
                        isShown: false,
                        iconData: Icons.edit,
                      );
                    },
                  );
                  appCubit.changeBottomSheetState(
                    isShown: true,
                    iconData: Icons.add,
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
