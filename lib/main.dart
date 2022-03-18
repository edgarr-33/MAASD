import 'package:flutter/material.dart';
import 'package:monitoreo/src/vistas/MonitorDem.dart';
import 'package:monitoreo/src/vistas/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MVP Demo',
      initialRoute: 'InitialPage',
      routes: {
        'InitialPage': (BuildContext context)=> Login(),
        'monitor': (BuildContext context)=> MonitorDem(),
      },
      // home: Login()
    );
  }
}
