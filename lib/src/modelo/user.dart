import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserModel {
  String? id;
  String name;
  String email;
  String password;
  List<GeoPoint> coords;
  // LatLng? coords;


  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.coords,

  });

  factory UserModel.fromFirestore(DocumentSnapshot userDoc) {
    Map userData = userDoc.data() as Map;
    return UserModel(
        id: userDoc.id,
        name: userData['name'],
        email: userData['email'],
        password: userData['password'],
        coords: userData['coords']);
  }

  void setFromFireStore(DocumentSnapshot userDoc) {
    Map userData = userDoc.data() as Map;
    this.id = userDoc.id;
    this.name = userData['name'];
    this.email = userData['email'];
    this.password = userData['password'];
    this.coords = userData['coords'];
  }

  Map<String, dynamic> userToMap(UserModel user) {
    return {
      'name': user.name,
      'email': user.email,
      'coords': user.coords,
    };
  }
}
