import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_utils/utils/poly_utils.dart';
import 'package:monitoreo/src/vistas/map_page.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:monitoreo/src/providers/location_provider.dart';
import 'package:monitoreo/src/providers/map_provider.dart';

class MonitorDem extends StatefulWidget {
  const MonitorDem({Key? key}) : super(key: key);

  @override
  State<MonitorDem> createState() => _MonitorDemState();
}

class _MonitorDemState extends State<MonitorDem> {

  // Completer<GoogleMapController> _googleMapController = Completer();
  // final GoogleMapController controller = await _googleMapController.future;
  final _location = LocationProvider();
  final _controller = MapProvider();
  final _initialCameraPosition = const CameraPosition(target: LatLng(16.615616682740654, -93.09023874839484), zoom: 16);
  final Set<Polygon> _polygons = HashSet<Polygon>();

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
      backgroundColor: const Color(0xffFFC9D9),
      appBar: AppBar(
        backgroundColor: const Color(0xff9F7FB1),
        title: const Center(
          child: Text('MonitorDem')
        ),
      ),
      body: Container(
        color: null,
        child: FirebaseAnimatedList(
            query: FirebaseDatabase.instance.ref("/"),
            itemBuilder: (_, snapshot, __, ____) {
       
              final json = snapshot.value as Map<dynamic, dynamic>;
           

              final frec = json['f_frecuencia'];
              double lat = json['f_latitude'];
              double long = json['f_longitude'];
              final temp = json['f_temperature'];
              final bat = json['f_baterÃ­a'];

              double tempAux = temp - 3.0;
              int frecInt = frec.toInt();

              getMarkers(lat, long);
              setPolygon(

                //universidad
                  // 1,
                  // 16.61613226251756,-93.0910093791682,
                  // 16.61633480425037,-93.09101043401931,
                  // 16.616344343149503,-93.09038424064279,
                  // 16.616144719943097,-93.09039326897023);

                // casa random
                  1,
                16.61712472632354, -93.09428488218826,
                16.61709324146582, -93.0942044159187,
                16.617011637830938, -93.09423660242652,
                16.617041837605374, -93.09431773924834);

              Point from = Point(lat, long);
              List<Point> polygon = [
                Point(16.61712472632354,-93.09428488218826),
                Point( 16.61709324146582, -93.0942044159187),
                Point(16.617011637830938, -93.09423660242652),
                Point(16.617041837605374, -93.09431773924834),
              ];
              bool contains = PolyUtils.containsLocationPoly(from, polygon);
              
              if (!contains) {
                final DateTime now = DateTime.now();
                return AlertDialog(
                  title: Text(
                      'la persona salio del limite el dia y hora  : ${now}'),
                );
              }
              if (tempAux > 38) {
                return const AlertDialog(
                  title: Text('Temperatura mas del limite'),
                );
              }

             
              return Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    height: height * 0.7,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: GoogleMap(
                            markers: Set.of(_controller.markers.values),
                            myLocationEnabled: true,
                            onMapCreated: _controller.onMapCreated,
                            initialCameraPosition: _initialCameraPosition,
                            polygons: _polygons,
                          ),
                        ),
                        // Text('Bateria: ${bat}', style: TextStyle(fontSize: 30)),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    height: 120,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 30)),
                          Text(
                            'Frecuencia: ${frec}',
                            style: const TextStyle(fontSize: 30),
                          ),
                          Text('Temperatura: ${temp}',
                              style: const TextStyle(fontSize: 30)),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }

  void getMarkers(double latitude, double longitude) {
    CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 16
      )
    );
    _controller.markers.clear();
    _controller.creadMarkers(LatLng(latitude, longitude));
  }

  void setPolygon(int id, double lat, double long, double lat2, double long2, double lat3, double long3, double lat4, double long4,) {
    final String polygonIdVal = 'polygon_id_$id';
    _polygons.add(Polygon(
      polygonId: PolygonId(polygonIdVal),
      points: [
        LatLng(lat, long),
        LatLng(lat2, long2),
        LatLng(lat3, long3),
        LatLng(lat4, long4)
      ],
      strokeWidth: 3,
      strokeColor: Colors.red,
      fillColor: Colors.red.withOpacity(0.15),
    ));
  }
}
