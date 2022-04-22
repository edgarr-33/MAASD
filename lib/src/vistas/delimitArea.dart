import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../providers/location_provider.dart';
import '../providers/map_provider.dart';

class DelimitAreaView extends StatefulWidget {
  const DelimitAreaView({Key? key}) : super(key: key);

  @override
  State<DelimitAreaView> createState() => _DelimitAreaViewState();
}

class _DelimitAreaViewState extends State<DelimitAreaView> {

  final _initialCameraPosition = const CameraPosition(target: LatLng(16.23055717297992, -93.9072327009249), zoom: 12);
  List<Marker> markers = [];
  List<LatLng> latlngs = [];
  int id = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          child: GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            onTap: (LatLng position) {
              Marker newMarker = Marker(
                markerId: MarkerId('$id'),
                position: LatLng(position.latitude, position.longitude),
                infoWindow: InfoWindow(title: 'Marcador $id en $position'),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
              );
              markers.add(newMarker);
              latlngs.add(position);
              id = id + 1;
              setState(() {
                print('Posicion del marcador nuevo $position');  
              });
              print('Lista de marcadores $latlngs');
            },
            markers: markers.map((e) => e).toSet(),
          )
        ),
      ),
    );
  }
}