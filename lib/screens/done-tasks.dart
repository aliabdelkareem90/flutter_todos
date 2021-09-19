import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/cubit/app-cubit.dart';
import 'package:flutter_todo_app/cubit/app-states.dart';
import 'package:flutter_todo_app/widgets/tasksBuilder.dart';

class DoneTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).doneTasks;
        return tasksBuilder(
          context: context,
          tasks: tasks,
          tasksType: 'Done Tasks',
          nullMsg: 'No Done Tasks',
        );
      },
    );
  }
}

// return Stack(
//   children: [
//     backgroundContainer(context, 'Done Tasks'),
//     Container(
//       margin: EdgeInsets.only(top: 240),
//       decoration: BoxDecoration(
//         color: Colors.white70,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20.0),
//           topRight: Radius.circular(20.0),
//         ),
//       ),
//       child: ConditionalBuilder(
//         condition: tasks.length > 0,
//         fallback: (context) => Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.list_rounded,
//                 size: 100,
//                 color: Colors.black45,
//               ),
//               Text(
//                 'No Done Tasks',
//                 style: TextStyle(
//                   fontSize: 22.0,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black45,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         builder: (context) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5.0),
//             child: ListView.separated(
//               itemCount: tasks.length,
//               separatorBuilder: (BuildContext context, int index) =>
//               const Divider(
//                 height: 3.0,
//               ),
//               itemBuilder: (BuildContext context, int index) =>
//                   defaultTaskTile(context, tasks[index]),
//             ),
//           );
//         },
//       ),
//     )
//   ],
// );
