import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/postsModel.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Fetch API
  // for array
  List<PostsModel> postlist =[];
  Future<List<PostsModel>> getPostApi()async{
   final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
   var data = jsonDecode(response.body.toString());
   if(response.statusCode==200){
     postlist.clear();
     for(Map i in data){
     postlist.add(PostsModel.fromJson(i));
     }
     return postlist;
   }else{
     return postlist;
   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Text("Loading...");
                  }else{
                    return ListView.builder(
                      itemCount: postlist.length,
                        itemBuilder: (context, index){
                        return Card(
                          child: Column(
                            children: [
                              Text("Title",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                              Text(postlist[index].title.toString()),
                              SizedBox(height: 10,),
                              Text("Description",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                              Text("${postlist[index].title}"),
                            ],
                          ),
                        );
                        }

                    );
                  }
                },),
          )
        ],
      ),
    );
  }
}
