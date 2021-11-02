import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  TextEditingController queryTEC=TextEditingController();
  String query='';
  bool notVisible=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users => ${query}", style: Theme.of(context).textTheme.headline6,),),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                      child: TextFormField(
                        obscureText: notVisible,
                        onChanged: (value){
                          setState(() {
                            this.query=value;
                          });
                        },
                        controller: queryTEC,
                        decoration: InputDecoration(
                          //icon: Icon(Icons.logout),
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                notVisible=!notVisible;
                              });
                            },
                            icon: Icon(notVisible==true?Icons.visibility:Icons.visibility_off),
                          ),
                          contentPadding: EdgeInsets.only(left: 20, right: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              width: 1, color: Colors.deepOrange
                            )
                          )
                        ),
                      ),
                  ),
                ),
                IconButton(onPressed: (){
                  setState(() {
                    this.query=queryTEC.text;
                  });
                },
                    icon: Icon(Icons.search, color: Colors.deepOrange,))
              ],
            )
          ],
        )
      ),
    );
  }
}