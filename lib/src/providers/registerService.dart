
import 'package:cloud_firestore/cloud_firestore.dart';

import '../modelo/user.dart';

class RegisterService {
  RegisterService();

  FirebaseFirestore db = FirebaseFirestore.instance;

  void createUser(String id, UserModel user) async {

    await db.collection('users').doc(id).set(user.userToMap(user)).onError((error, stackTrace) {
      print('-----------------');
      print(error);
    });
  }
}
