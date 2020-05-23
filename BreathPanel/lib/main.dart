import 'package:app_breath/screens/add_device.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Roboto",
        primaryColor: Color.fromRGBO(0, 202, 3, 1),
      ),
      home: AddDevice(),
    );
  }
}

