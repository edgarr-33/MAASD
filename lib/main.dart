import 'package:flutter/material.dart';
import 'package:monitoreo/src/vistas/MonitorDem.dart';
import 'package:monitoreo/src/vistas/alert.dart';
import 'package:monitoreo/src/vistas/delimitArea.dart';
import 'package:monitoreo/src/vistas/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:monitoreo/src/vistas/register.dart';
import 'package:monitoreo/src/vistas/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      initialRoute: 'register',
      routes: {
        'InitialPage': (BuildContext context)=> const Login(),
        'monitor': (BuildContext context)=> const MonitorDem(),
        'alerta': (BuildContext context)=> const Alerta(),
        'splash': (BuildContext context) => const SplashView(),
        'register': (BuildContext context) => const RegisterView(),
        'delimit': (BuildContext context) => const DelimitAreaView(),
      },
      // home: Login()
    );
  }
}
