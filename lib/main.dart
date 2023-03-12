import 'package:asbeza/bloc/bloc/asbeza_bloc.dart';
import 'package:asbeza/presentation/screens/home_page.dart';
import 'package:asbeza/presentation/screens/item_list.dart';
import 'package:flutter/material.dart';
import 'package:asbeza/presentation/screens/home_page.dart';
import 'package:asbeza/presentation/screens/history_page.dart';
import 'package:asbeza/presentation/screens/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: ((context) => ItemBloc()),
        child: HomePage(),
      ),
    );
  }
}
