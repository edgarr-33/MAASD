
import 'package:firebase_auth/firebase_auth.dart';
import 'package:monitoreo/src/modelo/user.dart';

import '../providers/registerService.dart';

class GmailAndPaswordRegister {
  GmailAndPaswordRegister();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future registerEmailPassword(UserModel user) async {
    RegisterService registro = RegisterService();
    final User? userRegistered;
    try {
      final UserCredential userCredential =
          (await auth.createUserWithEmailAndPassword(
              email: user.email, password: user.password));

      userRegistered = userCredential.user;
      print('||||||||||||||||||||||||||||||||');
      // print(userRegistered.uid);
      registro.createUser(userRegistered!.uid, user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return e;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return e;
      }
    } catch (e) {
      print(e);
    }
  }
}
