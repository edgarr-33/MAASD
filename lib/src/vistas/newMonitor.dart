import 'dart:collection';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_utils/utils/poly_utils.dart';
import '../api/NotificationApi.dart';
import '../providers/location_provider.dart';
import '../providers/map_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NuevoMonitor extends StatefulWidget {

  const NuevoMonitor({Key? key}) : super(key: key);

  @override
  State<NuevoMonitor> createState() => _NuevoMonitorState();
}

class _NuevoMonitorState extends State<NuevoMonitor> {


  late FlutterLocalNotificationsPlugin localNotification;
  

  void sendNotification({String? title, String? body})async{
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true
        );
   
   
    const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
        );

    const AndroidNotificationChannel channel = AndroidNotificationChannel('high_chanel', 'high importance notification',
      description:"thos channel is important fot notification",
      importance: Importance.max );
    
    flutterLocalNotificationsPlugin.show(0, title, body, NotificationDetails(
      android: AndroidNotificationDetails(channel.id, channel.name,channelDescription: channel.description)
    ));

  }


  final _location = LocationProvider();
  final _controller = MapProvider();
  final Set<Polygon> _polygons = HashSet<Polygon>();

  @override
  void initState() {
    _location.getLocation();
    
    super.initState();
    // var androidInitialize = const AndroidInitializationSettings('ic_launcher.png');
    // var initializatiooonSettings = InitializationSettings(
    //   android: androidInitialize
    // );
    // localNotification = FlutterLocalNotificationsPlugin();
    // localNotification.initialize(initializatiooonSettings);
  
  }

// Future<void> _showNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails('channelId', 'Local Notification',
//             channelDescription: 'prueba de notificacion',
//             importance: Importance.high
//             );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     var generalNotificationDetails = new NotificationDetails(android: androidPlatformChannelSpecifics);
    
//     await localNotification.show(0, 'title', 'body', generalNotificationDetails);
//   }

  // final String documentId;
  @override
  Widget build(BuildContext context) {
  final arguments = ModalRoute.of(context)!.settings.arguments as Map;
  String identificador = arguments['uid'];
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(identificador).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          String nameBD;
          String gmailBD;
          List<dynamic> coords = [];
          List<double> latList=[];
          List<double> longList=[];

          coords.add(data['coords']);
          nameBD=data['name'];
          gmailBD=data['email'];
          // print(coords);

          for (var i = 0; i < coords[0].length; i++) {
            latList.add(coords[0][i].latitude);
            longList.add(coords[0][i].longitude);
          }

          // print(latList);
          // print(longList);


          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          return Scaffold(
            backgroundColor: const Color(0xff2196F3),
            appBar: AppBar(
              backgroundColor: const Color(0xff2196F3),
              title: const Center(
                child: Text('MonitorDem')
              ),
              actions: [
                ElevatedButton(onPressed: (){
                  Navigator.pushReplacementNamed(context, 'edit',arguments: {'uid':identificador,'email':gmailBD,'name':nameBD});
                }, 
                child: const Icon(Icons.edit)),
                ElevatedButton(onPressed: (){
                  FirebaseAuth.instance.signOut();

                  Navigator.pushNamed(context, 'InitialPage');
                }, child: const Icon(Icons.power_settings_new_outlined ))
              ],
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
            int frecInt = frec.toInt();

            getMarkers(lat, long);
          

            setPolygon(
              1,
              latList[0],longList[0],
              latList[1],longList[1],
              latList[2],longList[2],
              latList[3],longList[3]);
            

            Point from = Point(lat, long);
            List<Point> polygon = [
              Point(  latList[0],longList[0]),
              Point(  latList[1],longList[1]),
              Point(  latList[2],longList[2]),
              Point(  latList[3],longList[3]),
            ];
            final _initialCameraPosition =  CameraPosition(target: LatLng( latList[0],longList[0]), zoom: 16);
            // Alerta de fuera del área
            bool contains = PolyUtils.containsLocationPoly(from, polygon);
            
            if (!contains) {
              sendNotification(
                              title: "Mensaje de alerta", 
                              body: "La persona salio fuera del perimetro de seguridad"
                            );
                // _showNotification();
                final DateTime now = DateTime.now();
                 return Dialog(
                   
                  insetPadding: const EdgeInsets.only(top: 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                          child: Column(
                            children: [ 
                               Text('la persona salio del limite el dia y hora  : $now', style: const TextStyle(fontSize: 20),),
                            ],
                          ),
                        ) ,
                      ),
                    const Positioned(
                      child: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        radius: 60,
                        child: Icon(Icons.assistant_photo,size: 50,color:Colors.white,),
                      ),
                      top: -60,
                      )
                    ],
                  ),
                );
                
            }
            // Alerta de temperatura
            if (temp > 38) {
              sendNotification(
                              title: "Mensaje de alerta",
                              body: "La persona tiene la temperatura alta"
                            );
              return Dialog(
                  insetPadding: const EdgeInsets.only(top: 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                          child: Column(
                            children: const [ 
                              Text('Temperatura alta', style: TextStyle(fontSize: 20),),
                            ],
                          ),
                        ) ,
                      ),
                    const Positioned(
                      child: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        radius: 60,
                        child: Icon(Icons.assistant_photo,size: 50,color:Colors.white,),
                      ),
                      top: -60,
                      )
                    ],
                  ),
                );
            }
             if (frecInt > 120) {
              sendNotification(
                              title: "Mensaje de alerta",
                              body: "La persona tiene el ritmo cardiaco alto"
                            );
              return Dialog(
                  insetPadding: const EdgeInsets.only(top: 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                          child: Column(
                            children: const [ 
                              Text('Ritmo cardiaco alto', style: TextStyle(fontSize: 20),),
                            ],
                          ),
                        ) ,
                      ),
                    const Positioned(
                      child: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        radius: 60,
                        child: Icon(Icons.assistant_photo,size: 50,color:Colors.white,),
                      ),
                      top: -60,
                      )
                    ],
                  ),
                );
            }




            // Diseño de la vista
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
                          'Frecuencia: ${frecInt}',
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
          }
        ),
      ),

          );

        }
 
        return const SizedBox(child: Center(child: CircularProgressIndicator(),), width: 100, height:100 ,);
      },
      
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
      strokeColor: Colors.green,
      fillColor: Colors.green.withOpacity(0.15),
    ));
  }
}