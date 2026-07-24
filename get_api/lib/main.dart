import 'package:flutter/material.dart';
import 'package:get_api/example_three.dart';
import 'package:get_api/sign_up.dart';
import 'package:get_api/upload_image.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Api Learning ',
      home: const UploadImage(),
    );
  }
}
