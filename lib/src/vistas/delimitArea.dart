
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../modelo/gmailRegister.dart';
import '../modelo/user.dart';
import '../providers/map_provider.dart';

class DelimitAreaView extends StatefulWidget {
  const DelimitAreaView({Key? key}) : super(key: key);

  @override
  State<DelimitAreaView> createState() => _DelimitAreaViewState();
}

class _DelimitAreaViewState extends State<DelimitAreaView> {
  
  final _initialCameraPosition = const CameraPosition(target: LatLng(16.23055717297992, -93.9072327009249), zoom: 8);
  final _controller = MapProvider();
  List<Marker> markers = [];
  List<GeoPoint> latlngs = [];

   
  int ids = 1;
  // String gmail = "";
  @override
  void initState() {
    super.initState();
  }

//  String? email = '';
 


  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    ValueNotifier<String> name = arguments['name'];
    ValueNotifier<String> gmail = arguments['email'];
    ValueNotifier<String> password = arguments['password'];
    print('-------------------${password.value}');
  
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
                    if (ids < 5) { 
                  
                      Marker newMarker = Marker(
                        markerId: MarkerId('$ids'),
                        position: LatLng(position.latitude, position.longitude),
                        infoWindow: InfoWindow(title: 'Marcador $ids en $position'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
                      );
                      markers.add(newMarker);
                      latlngs.add(GeoPoint(position.latitude, position.longitude));
                      ids = ids + 1;
                      setState(() {
                        print('Posicion del marcador nuevo $position');  
                      });
                      print('Lista de marcadores $latlngs');

                      if(ids==5){
                         showDialog(
                        context: context,
                         builder: (context)=> AlertDialog(
                           title: const Text('Ha colocado todas sus posiciones'),
                           actions: [
                              ElevatedButton(
                        child: const Text('Continuar'),
                          
                        onPressed:  ( 
                          name.value != '' &&
                          gmail.value != '' &&
                          password.value != '' )
                          ?()
                          {
                          UserModel user =  UserModel(
                                name: name.value,
                                email: gmail.value,
                                password: password.value, 
                                coords: latlngs,
                                );
                                print('--------------------------------------');
                          

                                GmailAndPaswordRegister register =GmailAndPaswordRegister();
                                print(user);
                                register
                                    .registerEmailPassword(user)
                                    .then((value) {
                                  if (value != null) {
                                    if (value.code == 'email-already-in-use') {

                                      print('Correo electronico ya registrado');
                                    } else if (value.code == 'weak-password') {
                                    print('Contraseña muy corta');
                                    }
                                  } else {
                                    print('-----------------------------');
                                    print('usuario creado');
                                    // showModalRegistered(context);
                                    verifyUser();
                                  }
                                });


                            }:
                          null,
                        )
                           ],
                         )
                      );
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
      print('click');
      Navigator.of(context).pushNamedAndRemoveUntil('InitialPage', (Route<dynamic> route) => false);
    }
  }
  
    void showModalRegistered(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.pink[900],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                width: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  color: Color(0xFF9A2073),
                ),
                child: Container(
                    margin: EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      color: Color(0xFFAA247E),
                    ),
                    child: Container(
                        margin: EdgeInsets.all(25.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Color(0xFFA5176E),
                        ),
                        child: Icon(
                          Icons.check,
                          size: 100.0,
                          color: Colors.white,
                        ))),
              ),
              SizedBox(height: 15.0),
              Container(
                child: Text(
                  "REGISTRO EXITOSO",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
 

}