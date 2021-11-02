import 'package:flutter/material.dart';

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