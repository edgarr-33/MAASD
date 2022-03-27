import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:monitoreo/src/vistas/map_page.dart';

import '../modelo/monitorDEM.dart';

class MonitorDem extends StatefulWidget {
  MonitorDem({Key? key}) : super(key: key);

  @override
  State<MonitorDem> createState() => _MonitorDemState();
}

class _MonitorDemState extends State<MonitorDem> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffFFC9D9),
      appBar: AppBar(
        backgroundColor: Color(0xff9F7FB1),
        title: const Center(child: Text('MonitorDem')),
      ),
      body: FirebaseAnimatedList(
          query: FirebaseDatabase.instance.ref("/"),
          itemBuilder: (_, snapshot, __, ____) {
            // print(snapshot.value); 
            final json = snapshot.value as Map<dynamic, dynamic>;


            final frec = json['f_frecuencia'];
            final lat = json['f_latitude'];
            final long = json['f_longitude'];
            final temp = json['f_temperature'];

            // if(temp > 38){
            //   return const AlertDialog(
            //     title: Text('temperatura mas del limite'),
            //     // Navigator.pushNamed(context, routeName)
                
            //   );
              
            // }

            //  if(temp > 10){
            //   return const AlertDialog(
            //     title: Text('temperatura menos del limite'),
            //   );
            // }
            

            // print(mensaje);
            // return Text(mensaje.toString());
            return Column(
              children: [
                Container(
                    height: height * 0.5,
                    child: Center(
                      child: MapPage(),
                    )
                ),
                                 Container(
                    height: height * 0.3,
                    // color: Colors.yellow[200],
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        Text('Frecuencia: ${frec}',style: TextStyle(fontSize: 30),),
                        Text('Longitud: ${long}',style: TextStyle(fontSize: 30)),
                        Text('Latitud: ${lat}',style: TextStyle(fontSize: 30)),
                        Text('Temperatura: ${temp}',style: TextStyle(fontSize: 30)),
                      ],
                    ),
                                 )

              ],
            );
          }),

      // body: StreamBuilder<DatabaseEvent>(
      //     stream: MonitorDEM().getDatas(),

      //     builder: (context, snapshot) {
      //       if (snapshot.hasError) {
      //         return const SnackBar(
      //             content: Text('Error inicializando Firebase'));
      //       } else if (snapshot.connectionState == ConnectionState.done) {
      //         print('connection state DONE');
      //         print(snapshot.data);

      //         // print(snapshot.data);

      //         // String stringVar = snapshot.data.toString();
      //         // List<String> lista =[];
      //         // List<double> listaDouble =[];

      //         // for (var i = 0; i < stringVar.length; i++) {
      //         //   if(stringVar[i]=="["||stringVar[i]==' '){
      //         //     String listvar ="";
      //         //     for (var j = i+1; j < stringVar.length; j++) {
      //         //       if(stringVar[j]=="," || stringVar[j]==']'){
      //         //         lista.add(listvar.replaceAll(RegExp(r' ') , ''));
      //         //         break;
      //         //       }
      //         //       listvar+=stringVar[j];

      //         //     }
      //         //   }

      //         // }
      //         // for (var i = 0; i < lista.length; i++) {
      //         //       listaDouble.add(double.parse(lista[i])) ;
      //         // }
      //         // print('-------------------------');
      //         // print(listaDouble);

      //         return Column(
      //           children: [
      //             // Container(
      //             //   height: height*0.5,
      //             //   child: Center(child: MapPage(lat, long),)
      //             // ),
      //             Container(
      //               height: height * 0.3,
      //               // color: Colors.yellow[200],
      //               child: Column(
      //                 children: [
      //                   const Padding(padding: EdgeInsets.only(top: 30)),
      //                   // Text('Frecuencia: ${listaDouble[0]}',style: TextStyle(fontSize: 30),),
      //                   // Text('Longitud: ${listaDouble[1]}',style: TextStyle(fontSize: 30)),
      //                   // Text('Latitud: ${listaDouble[2]}',style: TextStyle(fontSize: 30)),
      //                   // Text('Frecuencia: ${listaDouble[3]}',style: TextStyle(fontSize: 30)),
      //                 ],
      //               ),
      //             )
      //           ],
      //         );
      //       }
      //       return const CircularProgressIndicator();
      //     }),
    );
  }
}
