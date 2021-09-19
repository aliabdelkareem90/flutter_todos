import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/cubit/app-states.dart';
import 'package:flutter_todo_app/screens/archived-tasks.dart';
import 'package:flutter_todo_app/screens/done-tasks.dart';
import 'package:flutter_todo_app/screens/new-tasks.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  // Object
  static AppCubit get(context) => BlocProvider.of(context);

  // Bottom Sheet Numbers
  int currentIndex = 0;
  List<Widget> screens = [NewTasks(), DoneTasks(), ArchivedTasks()];
  List<String> titleScreen = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  void changeBottomNavBarState(int index) {
    currentIndex = index;
    emit(BottomNavBarState());
  }

  // Database
  Database _database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (Database _database, int version) {
        _database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print(error.toString());
        });
      },
      onOpen: (Database _database) {
        getDataFromDatabase(_database);
        print('opened');
      },
    ).then((value) {
      _database = value;
      emit(CreateDatabaseState());
    });
  }

  insertToDatabase({
    @required String title,
    @required String date,
    @required String time,
  }) async {
    return await _database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks (title,date,time,status) VALUES ("$title","$date","$time","new")')
          .then((value) {
        print('task inserted');
        emit(InsertDatabaseState());
        getDataFromDatabase(_database);
      }).catchError((err) {
        print(err.toString());
      });
    });
  }

  void getDataFromDatabase(Database _database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    // emit(AppCreateDatabaseLoadingState());
    _database.rawQuery('SELECT * FROM tasks ORDER BY date DESC').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
      emit(GetDatabaseState());
    });
  }

  void updateData({@required String status, @required int id}) async {
    _database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(_database);
      emit(UpdateDatabaseState());
    });
  }

  void deleteData({@required int id}) async {
    _database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(_database);
      emit(DeleteDatabaseState());
    });
  }

  // floating action bottom
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState(
      {@required bool isShown, @required IconData iconData}) {
    isBottomSheetShown = isShown;
    fabIcon = iconData;
    emit(BottomSheetState());
  }
}
