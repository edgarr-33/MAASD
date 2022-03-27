import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:monitoreo/src/resource/style_map.dart';

class MapProvider {

  Map<MarkerId, Marker> markers = Map();
  List<dynamic> data = [];
  List<dynamic> addres = [];
  List<dynamic> photo = [];

  void creadMarkers( LatLng position) async {
    final markerId = MarkerId(markers.length.toString());
    final marker = Marker(
      markerId: markerId, 
      position: position,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      consumeTapEvents: true,
      // onTap: () {
      //   getRoomsByMotel(id);
      // }
    );
    markers[markerId] = marker;
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
  }

  // Future<void> getRoomsByMotel(String id) async {
  //   List<dynamic> room = [];
  //   List<dynamic> dataCard = [];
  //   List<String> name = [];
    
  //   // await FirebaseFirestore.instance.collection('motels').get().then((QuerySnapshot querySnapshot) {
  //   //   querySnapshot.docs.forEach((doc) {
  //   //     if (doc.id == id) {
  //   //       room.add(doc['rooms']);
  //   //     }
  //   //   });
  //   // });

  //   for (var i = 0; i < room[0].length; i++) {
  //     dataCard.add(await getRoom(room, i));
  //   }
    
  //   print('NOMBRE DE LAS HABITACIONES');
  //   for (var i = 0; i < dataCard.length; i++) {
  //     name.add(dataCard[i][0][0]);
  //     print(dataCard[i][0][0]);  
  //   }
  //   // print(dataCard[0][0][1]);
  //   // print(dataCard[0][0][2]);
  //   data.add(dataCard[0][0][2]);
  //   print(data);
  // }

  // Future<List<dynamic>> getRoom(List roomByMotel, int i) async {
  //   List<dynamic> data = [];
  //   await FirebaseFirestore.instance.collection('rooms').get().then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       if (doc.id == roomByMotel[0][i]) {
  //           data.add([doc['name'], doc['address'], doc['photoGallery'][0]]);  
  //       }
  //     });
  //   });
  //   return data;
  // }
}
