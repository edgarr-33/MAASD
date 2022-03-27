import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class MonitorDEM {
  StreamSubscription<DatabaseEvent> getDatas(){
    
    
    // List<double> listaDouble = [];
  
   
    DatabaseReference datos = FirebaseDatabase.instance.ref("MONITORDEM/");
    Stream<DatabaseEvent> monit = datos.onValue;
    
    return monit.listen((DatabaseEvent event) {
      List<double> listaDouble = [];
      List<String> lista = [];
      String stringVar = event.snapshot.value.toString();
      

      for (var i = 0; i < stringVar.length; i++) {
        if (stringVar[i] == ":") {
          String listvar = "";
          for (var j = i + 1; j < stringVar.length; j++) {
            if (stringVar[j] == "," || stringVar[j] == '}') {
              lista.add(listvar.replaceAll(RegExp(r' '), ''));
              break;
            }
            listvar += stringVar[j];
          }
        }
      }
      for (var i = 0; i < lista.length; i++) {
        listaDouble.add(double.parse(lista[i]));
      }
      // print('-------------');
      print('lista dentro del metodo : $listaDouble');

      
      
    }
    );
    




    
    
  }
}

  // DatabaseReference datos = FirebaseDatabase.instance.ref("MONITORDEM/");

  // Stream<DatabaseEvent> monit = datos.onValue;

  // monit.listen((DatabaseEvent event) {

    //   List<String> lista = [];
    //   List<double> listaDouble = [];
    //   // print('snapshot: ${event.snapshot.value}');


    //   String stringVar = event.snapshot.value.toString();
      

    //   for (var i = 0; i < stringVar.length; i++) {
    //     if (stringVar[i] == ":") {
    //       String listvar = "";
    //       for (var j = i + 1; j < stringVar.length; j++) {
    //         if (stringVar[j] == "," || stringVar[j] == '}') {
    //           lista.add(listvar.replaceAll(RegExp(r' '), ''));
    //           break;
    //         }
    //         listvar += stringVar[j];
    //       }
    //     }
    //   }
    //   for (var i = 0; i < lista.length; i++) {
    //     listaDouble.add(double.parse(lista[i]));
    //   }
    //   // print('-------------');
    //   // print('lista: $listaDouble');
    // });


    // DatabaseReference datos = FirebaseDatabase.instance.ref("MONITORDEM/");
    // DatabaseEvent mon = await datos.once();
    // String stringVar = mon.snapshot.value.toString();
    // List<String> lista = [];
    // List<double> listaDouble = [];

    // for (var i = 0; i < stringVar.length; i++) {
    //   if (stringVar[i] == ":") {
    //     String listvar = "";
    //     for (var j = i + 1; j < stringVar.length; j++) {
    //       if (stringVar[j] == "," || stringVar[j] == '}') {
    //         lista.add(listvar.replaceAll(RegExp(r' '), ''));
    //         break;
    //       }
    //       listvar += stringVar[j];
    //     }
    //   }
    // }
    // for (var i = 0; i < lista.length; i++) {
    //   listaDouble.add(double.parse(lista[i]));
    // }
