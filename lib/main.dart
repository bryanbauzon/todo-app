import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/app/common/commons.dart';
import 'package:todo_list/app/view/todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:  Commons().appColor
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      home: Todo() ,
    );
  }
}
