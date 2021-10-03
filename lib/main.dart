import 'package:byam/book_selection.dart';
import 'package:byam/home.dart';
import 'package:byam/user_info.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        initialRoute: "/",
        routes: {
          '/': (context) => const HomeScreen(),
          '/register': (context) => UserInfoForm(),
          '/book_selection': (context) => BookSelectionScreen(),
        });
  }
}
