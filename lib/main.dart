import 'package:challenge/src/api/services.dart';
import 'package:challenge/src/bloc/dash_borad_bloc/dash_board_bloc.dart';
import 'package:challenge/src/screens/dash_board_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Challenge',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => DashBoardBloc(dashBoardRepo: DashBoardServices()),
        child: DashBoardPage(),
      ),
    );
  }
}
