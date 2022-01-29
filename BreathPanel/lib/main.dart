import 'dart:ffi';

import 'package:app_breath/screens/add_device.dart';
import 'package:app_breath/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  SyncfusionLicense.registerLicense(DotEnv().env["SYNCFUSION_LICENSE"]);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BreathPanel',
      theme: ThemeData(
        fontFamily: "Roboto",
        primaryColor: Color.fromRGBO(0, 202, 3, 1),
      ),
      home: Dashboard(),
    );
  }
}
