import 'package:firebase_database/firebase_database.dart';
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
  //  print(this.lat);

  // double latitud = 16.7826;
  // double longitud = -93.12002;

  final _location = LocationProvider();
  final _controller = MapProvider();
  final _initialCameraPosition =
      const CameraPosition(target: LatLng(16.7826, -93.12002), zoom: 16);
  List<LatLng> coordenadas = [];

  @override
  void initState() {
    print(lat);
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
          ),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   bottom: 20,
          //   child: carousel()
          // )
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

  // void getCoordinate() {
  //   List<String> latitude = [];
  //   List<String> longitude = [];
  //   List<String> idMarker = [];
  //   FirebaseFirestore.instance.collection('motels').get().then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       latitude.add(doc["location"].latitude.toString());
  //       longitude.add(doc["location"].longitude.toString());
  //       idMarker.add(doc.id);
  //     });
  //     getMarkers(latitude, longitude, idMarker);
  //   });
  // }

  void getMarkers(double latitude, double longitude) async {
    setState(() {
      print("si activa");
      _controller.creadMarkers(LatLng(latitude, longitude));
    });
  }

  // Widget carousel() {
  //   return CarouselSlider(
  //     options: CarouselOptions(
  //       // height: size.init(context)[0] * 65,
  //       enlargeCenterPage: true,
  //       enableInfiniteScroll: false,
  //       // viewportFraction: 0.8
  //     ),
  //     items: listCards(),
  //   );
  // }

  // List<Widget> listCards() {
  //   List<Widget> cards = [];
  //   List<String> name = ['Habitacion sencilla', 'Habitacion especial'];
  //   List<String> addres =['Perif. Sur Pte. 2255, Penipak, 29060 Tuxtla Gutiérrez, Chis.', 'Perif. Sur Pte. 2255, Penipak, 29060 Tuxtla Gutiérrez, Chis.'];
  //   List<String> photo = ['https://firebasestorage.googleapis.com/v0/b/aurora-app-dev.appspot.com/o/moteles-de-paso-en-cdmx-para-divertirse-1.jpg?alt=media&token=415cba8f-fc90-4094-864d-f2c6085150c7',
  //                         'https://firebasestorage.googleapis.com/v0/b/aurora-app-dev.appspot.com/o/moteles-en-interlomas-para-darle-un-twist-a-tu-dia.jpg?alt=media&token=ebc866b4-e4cb-4fba-a934-f30670f593bc'];

  //   if (name.length > 0) {
  //     for (var i = 0; i < name.length; i++) {
  //       print('ENTRAMOS AL FOR');
  //       print(name[i]);
  //       print(addres[i]);
  //       print(photo[i]);
  //       cards.add(card(name[i], addres[i], photo[i]));
  //       // cards.add(card());
  //     }
  //     return cards;
  //   }
  //   else {
  //     return cards;
  //   }
  // }

  // Widget card(String name, String addres, String photo) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(20),
  //       color: Colors.white
  //     ),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(20),
  //       child: Column(
  //         children: <Widget> [
  //           AspectRatio(
  //             aspectRatio: 8 / 3,
  //             child: Container(
  //               decoration: new BoxDecoration(
  //                 image: new DecorationImage(
  //                   image: NetworkImage('$photo'),
  //                   fit: BoxFit.cover,
  //                   alignment: FractionalOffset.center
  //                 ),
  //               )
  //             ),
  //           ),
  //           ListTile(
  //             title: Text('$name', style: TextStyle(fontSize: 20),),
  //             subtitle: Row(
  //               children: <Widget> [
  //                 Icon(Icons.location_on),
  //                 Expanded(
  //                   child: Text('$addres'),
  //                 )
  //               ],
  //             )
  //           ),
  //         ],
  //       ),
  //     )
  //   );
  // }
}
