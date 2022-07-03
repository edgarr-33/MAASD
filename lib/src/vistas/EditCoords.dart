
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../providers/map_provider.dart';

class EditDelimitAreaView extends StatefulWidget {
  const EditDelimitAreaView({Key? key}) : super(key: key);

  @override
  State<EditDelimitAreaView> createState() => _EditDelimitAreaViewState();
}

class _EditDelimitAreaViewState extends State<EditDelimitAreaView> {
  
  final _initialCameraPosition = const CameraPosition(target: LatLng(16.23055717297992, -93.9072327009249), zoom: 8);
  final _controller = MapProvider();
  List<Marker> markers = [];
  List<GeoPoint> latlngs = [];

  int id = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  final arguments = ModalRoute.of(context)!.settings.arguments as Map;
  String identificador = arguments['uid'];
  String email = arguments['email'];
  String name = arguments['name'];
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned.fill(
                child: GoogleMap(
                  onMapCreated: _controller.onMapCreated,
                  initialCameraPosition: _initialCameraPosition,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  mapType: MapType.satellite,
                  onTap: (LatLng position) {
                    if (id < 5) {
                      Marker newMarker = Marker(
                        markerId: MarkerId('$id'),
                        position: LatLng(position.latitude, position.longitude),
                        infoWindow: InfoWindow(title: 'Marcador $id en $position'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
                      );
                      markers.add(newMarker);
                      latlngs.add(GeoPoint(position.latitude, position.longitude));
                      id = id + 1;
                      setState(() {
                        print('Posicion del marcador nuevo $position');  
                      });
                      print('Lista de marcadores $latlngs');

                      if(id == 5){
                        showDialog(
                        context: context, 
                        builder: (context)=>AlertDialog(
                          title: const Text('Ha colocado todas sus posiciones'),
                          actions: [
                            ElevatedButton(
                              onPressed: (){
                                CollectionReference users = FirebaseFirestore.instance.collection('users');

                                Future<void> updateUser() {
                                  return users
                                    .doc(identificador)
                                    .update({'coords':latlngs,'email':email,'name':name })
                                    .then((value) => print("User Updated"))
                                    .catchError((error) => print("Failed to update user: $error"));
                                }
                                updateUser();
                                Navigator.pushReplacementNamed(context, 'mon',arguments: {'uid':identificador});
                             

                              }, 
                              child: const Text('Continuar'),
                            )],
                        ));
                      }


                    }
                  },
                  markers: markers.map((e) => e).toSet(),
                )
              )
            ],
          )
        ),
      ),
    );
  }
      void verifyUser() {
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      Navigator.of(context).pushNamedAndRemoveUntil('mon', (Route<dynamic> route) => false);
    }
  }
  
}