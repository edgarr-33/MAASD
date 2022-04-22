import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:monitoreo/src/providers/location_provider.dart';
import 'package:monitoreo/src/providers/map_provider.dart';

class MapPage extends StatefulWidget {
  double long;
  double lat;

  MapPage(this.lat, this.long, {Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState(lat, long);
}

class _MapPageState extends State<MapPage> {

  _MapPageState(this.lat, this.long);
  double long;
  double lat;

  final _location = LocationProvider();
  final _controller = MapProvider();
  final _initialCameraPosition =
  const CameraPosition(target: LatLng(16.7826, -93.12002), zoom: 16);
  List<LatLng> coordenadas = [];
  final Set<Polygon> _polygons = HashSet<Polygon>();

  @override
  void initState() {
    // print(lat);
    getMarkers(lat, long);
    _location.getLocation();
    super.initState();
    updateCoordenadas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              markers: Set.of(_controller.markers.values),
              myLocationEnabled: true,
              onMapCreated: _controller.onMapCreated,
              initialCameraPosition: _initialCameraPosition,
              // zoomGesturesEnabled: true,
            ),
          )
        ],
      ),
    );
  }

  void updateCoordenadas() {
    print(_location.locationData);
    print('BIENVENIDOS');
    // setState(() {
    //   ;
    // });
  }

  void getMarkers(double latitude, double longitude) async {
    setState(() {
      // print("Si activa");
      _controller.creadMarkers(LatLng(latitude, longitude));
    });
  }

  void setPolygon(int id,double lat,double long,double lat2,double long2,) {
    final String polygonIdVal = 'polygon_id_$id';
    _polygons.add(
      Polygon(
      polygonId: PolygonId(polygonIdVal),
      points: [
        LatLng(lat,long),
        LatLng(lat2,long2)
      ],
      strokeWidth: 2,
      strokeColor: Colors.yellow,
      fillColor: Colors.yellow.withOpacity (0.15),
      )
    );
  }
}
