import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'cubit/app-blog-observer.dart';
import 'layouts/home-layout.dart';

main(List<String> args) {
  Bloc.observer = AppBlocObserver();
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF6A82FB),
        accentColor: Color(0xFFFC5C7D),
      ),
      home: HomeLayout(),
    );
  }
}
