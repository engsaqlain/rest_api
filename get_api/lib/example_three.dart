import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_api/models/api_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _State();
}

class _State extends State<ExampleThree> {
  List<ApiModel> userList = [];
  Future<List<ApiModel>> getdata() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(ApiModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" GET API"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getdata(),
              builder: (context, AsyncSnapshot<List<ApiModel>> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            RowData(
                              title: "Name",
                              value: snapshot.data![index].name.toString(),
                            ),
                            RowData(
                              title: "UserName",
                              value: snapshot.data![index].username.toString(),
                            ),
                            RowData(
                              title: "Email",
                              value: snapshot.data![index].email.toString(),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RowData extends StatelessWidget {
  String title, value;
  RowData({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), Text(value)]),
    );
  }
}
