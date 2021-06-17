import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/Presentation/screens/home_screen.dart';
import 'logic/bloc/home_screen_bloc.dart';
import 'logic/bloc/home_screen_event.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  HomeBloc homeBloc;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Architecture demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => homeBloc = HomeBloc([]
        )..add(HomeLoadEvent(0)),
        child: HomeScreen(homeBloc: homeBloc,),
      ),
    );
  }
}