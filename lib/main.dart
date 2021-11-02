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

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"),),
      drawer: Drawer(),
      body: Center(
        child: Text("Bienvenu"),
      ),
    );
  }
}

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User", style: Theme.of(context).textTheme.headline3,),),
      body: Center(
        child: Text("Users"),
      ),
    );
  }
}