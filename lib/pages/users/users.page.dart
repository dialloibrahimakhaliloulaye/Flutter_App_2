import 'dart:convert';

import 'package:app_2/pages/repositories/home.page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsersPage extends StatefulWidget {

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  TextEditingController queryTEC=TextEditingController();
  String query='';
  bool notVisible=false;
  dynamic data;
  int totalPages=0;
  int currentPage=0;
  int pageSize=20;
  ScrollController scrollController=ScrollController();
  List<dynamic>items=[];

  void _search(String query){
    String url="https://api.github.com/search/users?q=${query}&per_page=$pageSize&page=$currentPage";
    http.get(Uri.parse(url))
      .then((response) {
        setState(() {
          data=json.decode(response.body);
          items.addAll(data['items']);
          if(data['total_count'] % pageSize ==0) {
            totalPages = data['total_count'] ~/ pageSize;
          } else totalPages= (data['total_count'] / pageSize).floor()+1;
        });
    })
      .catchError((err){
        print(err);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
        setState(() {
          if(currentPage<totalPages-1){
            ++currentPage;
            _search(query);
          }

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users => ${query} => $currentPage / $totalPages",
        style: Theme.of(context).textTheme.headline6,),),
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
                    items=[];
                    currentPage=0;
                    this.query=queryTEC.text;
                    _search(query);
                  });
                },
                    icon: Icon(Icons.search, color: Colors.deepOrange,))
              ],
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(height: 2, color: Colors.deepOrange,),
                controller: scrollController,
                itemCount: items.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>GitRepositoriesPage(
                              login: items[index]['login'], avatarUrl: items[index]['avatar_url'],)));
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(items[index]['avatar_url']),
                                radius: 38,
                              ),
                              SizedBox(width: 25,),
                              Text("${items[index]['login']}", style: TextStyle(fontSize: 17),),
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                child: Text("${items[index]['score']}", style: TextStyle(fontSize: 15),),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }
              ),
            )
          ],
        )
      ),
    );
  }
}