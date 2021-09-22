import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/cubit/app-cubit.dart';
import 'package:flutter_todo_app/cubit/app-states.dart';
import 'package:flutter_todo_app/widgets/bottomSheet-form.dart';

class HomeLayout extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
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
                      desc: descController.text,
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
                    descController.text = '';
                    timeController.text = '';
                    dateController.text = '';
                  }
                } else {
                  _scaffoldKey.currentState
                      .showBottomSheet((context) =>
                        bottomSheetForm(
                          context: context,
                          formKey: _formKey,
                          titleController: titleController,
                          descController: descController,
                          timeController: timeController,
                          dateController: dateController,
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
