import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:monitoreo/src/vistas/map_page.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:monitoreo/src/providers/location_provider.dart';
import 'package:monitoreo/src/providers/map_provider.dart';

class MonitorDem extends StatefulWidget {
  MonitorDem({Key? key}) : super(key: key);

  @override
  State<MonitorDem> createState() => _MonitorDemState();
}

class _MonitorDemState extends State<MonitorDem> {
  Completer<GoogleMapController> _googleMapController = Completer();

// final GoogleMapController controller = await _googleMapController.future;
  final _location = LocationProvider();
  final _controller = MapProvider();
  final _initialCameraPosition =
      const CameraPosition(target: LatLng(16.61774, -93.0787998), zoom: 16);
  @override
  void initState() {
    _location.getLocation();
    super.initState();
  }

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
      body: Container(
        child: FirebaseAnimatedList(
            query: FirebaseDatabase.instance.ref("/"),
            itemBuilder: (_, snapshot, __, ____) {
              // print(snapshot.value);
              final json = snapshot.value as Map<dynamic, dynamic>;
              double lat1 = 16.782633382832646;
              double long1 = -93.12002440061053;
              double lat2 = 16.78256404774343;
              double long2 = -93.1200512226987;
              double lat3 = 16.782598715291208;
              double long3 = -93.1199519809725;
              double lat4 = 16.78253965205788;
              double long4 = -93.11998148526946;

              final frec = json['f_frecuencia'];
              double lat = json['f_latitude'];
              double long = json['f_longitude'];
              final temp = json['f_temperature'];
              final bat = json['f_baterÃ­a'];

              if (temp > 38) {
                return const AlertDialog(
                  title: Text('temperatura mas del limite'),
                );
              }

              if (temp < 10) {
                return const AlertDialog(
                  title: Text('temperatura menos del limite'),
                );
              }
              print(lat);
              getMarkers(lat, long);

              // if(lat>lat1 || lat < lat2 || lat < lat3|| lat < lat4  || long < long1 || long < long2 || long > long3 || long >long4){
              //   // print(lat);
              //   // print(lat1-lat);
              //   // print(lat2-lat);
              //   // print(lat3-lat);
              //   // print(lat4-lat);

              //   final DateTime now = DateTime.now();

              //   return  AlertDialog(

              //     title: Text('la persona salio del limite el dia y hora  : ${now}'),
              //     // content: Text('data'),

              //   );
              // }
              // if(bat < 0.0001){
              //   showDialog(
              //     context: context,
              //   builder: (context)=> const AlertDialog(
              //     title: Text('bateria baja'),

              //   )
              //   );
              // }

              return Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    // width: double.infinity,
                    height: height * 0.3,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: GoogleMap(
                            markers: Set.of(_controller.markers.values),
                            myLocationEnabled: true,
                            onMapCreated: _controller.onMapCreated,
                            initialCameraPosition: _initialCameraPosition,
                            // zoomGesturesEnabled: true,
                          ),
                        ),
                        // Positioned(
                        //   left: 0,
                        //   right: 0,
                        //   bottom: 20,
                        //   child: carousel()
                        // )
                      ],
                    ),
                    //MapPage(lat,long),
                  ),
                  Container(
                    // color: Colors.transparent,
                    // width: double.infinity,
                    height: height * 0.3,
                    // color: Colors.yellow[200],
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        Text(
                          'Frecuencia: ${frec}',
                          style: TextStyle(fontSize: 30),
                        ),
                        Text('Temperatura: ${temp}',
                            style: TextStyle(fontSize: 30)),
                        Text('Bateria: ${bat}', style: TextStyle(fontSize: 30)),
                      ],
                    ),
                  )
                ],
              );
            }),
      ),

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

  void getMarkers(double latitude, double longitude) {
    (CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 16)));

    _controller.markers.clear();

    _controller.creadMarkers(LatLng(latitude, longitude));
  }
}
