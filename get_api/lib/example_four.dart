import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// in this example if your flugin is not creating model. you can easily use this

class ExampleFour extends StatefulWidget {
  const ExampleFour({super.key});
  @override
  State<ExampleFour> createState() => _ExampleFourState();
}
class _ExampleFourState extends State<ExampleFour> {
  var data;
  Future<void> getUserApi() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Api"), centerTitle: true),
      body: FutureBuilder(
        future: getUserApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      RowData(
                        title: 'ID',
                        value: data[index]['id'].toString(),
                      ),
                      RowData(
                        title: 'Name',
                        value: data[index]['name'].toString(),
                      ),
                      RowData(
                        title: 'UserName',
                        value: data[index]['username'].toString(),
                      ),
                      RowData(
                        title: 'email',
                        value: data[index]['email'].toString(),
                      ),
                      RowData(
                        title: 'Address',
                        value: data[index]['address']['street'].toString(),
                      ),
                      RowData(
                        title: 'City',
                        value: data[index]['address']['city'].toString(),
                      ),
                      RowData(

                        title: 'Phone',
                        value: data[index]['phone'].toString(),
                      ),

                    ],

                  ),
                );
              },
            );
          }
        },
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
        children: [Text(title), Text(value)],
      ),
    );
  }
}
