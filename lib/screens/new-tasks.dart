import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/cubit/app-cubit.dart';
import 'package:flutter_todo_app/cubit/app-states.dart';
import 'package:flutter_todo_app/widgets/tasksBuilder.dart';

class NewTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        return tasksBuilder(
          context: context,
          tasks: tasks,
          tasksType: 'New Tasks',
          nullMsg: 'No New Tasks',
        );
      },
    );
  }
}

