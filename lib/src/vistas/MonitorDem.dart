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
  const CameraPosition(target: LatLng(16.615616682740654, -93.09023874839484), zoom: 16);
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
        color: null,
        child: FirebaseAnimatedList(
          query: FirebaseDatabase.instance.ref("/"),
          itemBuilder: (_, snapshot, __, ____) {
            // print(snapshot.value);
            final json = snapshot.value as Map<dynamic, dynamic>;
            // , , ,, 
            // double lat1a = 16.622040052123793;
            // double long1a = -93.10175065994065;
            // double lat2a = 16.62201113819912;
            // double long2a = -93.10164001881802;
            // double lat3a = 16.621949455145256;
            // double long3a =  -93.10177681147871;
            // double lat4a = 16.621916686014835;
            // double long4a =-93.10166818201287;
            // ,

            double lat1d = 16.61631385185811;
            double long1d = -93.09100900492535;
            double lat2d =16.616328407550533;
            double long2d =-93.09038494867774;
            double lat3d = 16.616117349902364;
            double long3d =  -93.09100520742285;
            double lat4d = 16.616134331560794;
            double long4d =-93.09039507535113;

            final frec = json['f_frecuencia'];
            double lat = json['f_latitude'];
            double long = json['f_longitude'];
            final temp = json['f_temperature'];
            final bat = json['f_baterÃ­a'];

            double tempAux = temp -3.0;
            int frecInt = frec.toInt();

            // print('latitud $lat');
            getMarkers(lat, long);

            if(lat>lat1d|| lat > lat2d || lat < lat3d|| lat < lat4d|| long < long1d|| long > long2d|| long < long3d || long >long4d ) {
            // if(lat >lat1d|| lat > lat2d|| lat > lat3d|| lat > lat4d|| long < long1d|| long < long2d|| long < long3d|| long <long4d ){ 
            // if(lat>lat1d|| lat > lat2d || lat > lat3d|| lat > lat4d|| long < long1d|| long > long2d|| long < long3d|| long >long4d){

   
              // print(lat);
              // print(lat1-lat);
              // print(lat2-lat);
              // print(lat3-lat);
              // print(lat4-lat); 

              final DateTime now = DateTime.now();
              return  AlertDialog(
                title: Text('la persona salio del limite el dia y hora  : ${now}'),
                // content: Text('data'),
              );
            }
            if (tempAux > 45) {
              return const AlertDialog(
                title: Text('Temperatura mas del limite'),
              );
            }


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
                  height: height * 0.7,
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
                    ],
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  // height: height * 0.3,
                  height: 120,
                  // color: Colors.yellow[200],
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        Text(
                          'Frecuencia: ${frec}',
                          style: const TextStyle(
                            fontSize: 30
                          ),
                        ),
                        Text(
                          'Temperatura: ${temp}',
                          style: const TextStyle(
                            fontSize: 30
                          )
                        ),
                        // Text('Bateria: ${bat}', style: TextStyle(fontSize: 30)),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }

  void getMarkers(double latitude, double longitude) {
    (CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 16
      )
    ));
    _controller.markers.clear();
    _controller.creadMarkers(LatLng(latitude, longitude));
  }
}
