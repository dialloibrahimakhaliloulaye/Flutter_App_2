import 'package:app_2/pages/home/home.page.dart';
import 'package:app_2/pages/users/users.page.dart';
import 'package:flutter/material.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange
      ),
      routes: {
        "/": (context)=>HomePage(),
        "/users": (context)=>UsersPage(),
      },
      initialRoute: "/users",
    );
  }
}

