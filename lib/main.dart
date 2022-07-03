import 'package:flutter/material.dart';
import 'package:monitoreo/src/vistas/EditCoords.dart';
import 'package:monitoreo/src/vistas/ResetPasww.dart';
import 'package:monitoreo/src/vistas/delimitArea.dart';
import 'package:monitoreo/src/vistas/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:monitoreo/src/vistas/newMonitor.dart';
import 'package:monitoreo/src/vistas/register.dart';

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
      initialRoute: 'InitialPage',
      routes: {
        'InitialPage': (BuildContext context)=> const Login(), //pagina principal
        'register': (BuildContext context) => const RegisterView(),
        'delimit': (BuildContext context) => const DelimitAreaView(),
        'mon': (BuildContext context)=>  const NuevoMonitor(),
        'reset': (BuildContext context)=> ResetPass(),
        'edit': (BuildContext context) => const EditDelimitAreaView(),
      },
    
    );
  }
}
