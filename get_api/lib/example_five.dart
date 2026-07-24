import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_api/models/product_model.dart';
import 'package:http/http.dart' as http;

class ExampleFive extends StatefulWidget {
  const ExampleFive({super.key});

  @override
  State<ExampleFive> createState() => _ExampleFiveState();
}

class _ExampleFiveState extends State<ExampleFive> {
  Future<ProductModel> getProductApi() async {
    var data;
    final response = await http.get(Uri.parse("https://api.jsonsilo.com/public/41366151-368c-4fc2-8581-c76df6aca9fb"));
    data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductModel.fromJson(data);
    } else {
      return ProductModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Api'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductModel>(future: getProductApi(),
                builder: (context, snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index){
                     return Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         ListTile(
                           title: Text(snapshot.data!.data![index].shop.toString()),
                           subtitle: Text(snapshot.data!.data![index].salePercent.toString()),
                           leading: CircleAvatar(
                             backgroundImage:  NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                           )
                         ),
                         Container(

                           height: MediaQuery.of(context).size.height *.3,
                           width: MediaQuery.of(context).size.width * 1,
                           child: ListView.builder(
                             scrollDirection: Axis.horizontal,
                             itemCount: snapshot.data!.data![index].images!.length,
                               itemBuilder: (context, position) {
                                 return Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Container(
                                     height: MediaQuery.of(context).size.height *.25,
                                     width: MediaQuery.of(context).size.width *.5,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(10),
                                       image: DecorationImage(
                                           fit: BoxFit.cover,
                                           image: NetworkImage(snapshot.data!.data![index].images![position].url!))
                                     ),
                                   ),
                                 );
                               },),
                         )
                       ],
                     );
                    }

                );
              }else{
                return Center(child: Text('loading'),);
              }

                },),
          ),
        ],
      ),
    );
  }
}
