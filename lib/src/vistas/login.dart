import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}
late String identificador;
class _LoginState extends State<Login> {

  Future<FirebaseApp> _initializeFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('MonitorDem')
        ),
      ),
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return login();
          }
          return const Center(child: CircularProgressIndicator(),);
        },
        
        ),
      // body: login(width: width, height: height, emailController: _emailController, passwordController: _passwordController)          
    );
  }
}

class login extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  
 

  // login function
  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context})async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      identificador = userCredential.user!.uid;
      print(userCredential.user!.uid);
      
    } on FirebaseAuthException catch(e){
      if(e.code == "user-not-found"){
        print('no user found fot that email');
      }
    }
    return user;
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset('assets/logo.png',),
          Container(
            width: 500,
            height: 50 ,
            margin: const EdgeInsets.only(top: 50),
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            width: 500 ,
            height: 50 ,
            margin: const EdgeInsets.only(top: 50),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                // hintText: 'Contraseña'
              ),
            ),
          ),
           Container(
               margin: const EdgeInsets.only(top: 30),
                width: 300,
                height: 48,
                child:ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        side: const BorderSide(color: Colors.black38),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                          
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const[
                          // Icon(Icons.email ,color:ColorSelect.txtBoSubHe),
                          Text('Ingresar',
                          style: TextStyle(fontSize: 14,color: Colors.black),  
                        )
                        ],
        
                      ),
                      onPressed: () async{
                  User? user = await loginUsingEmailPassword(
                    email: _emailController.text, 
                    password: _passwordController.text, context: context);
                    print(user);
                    if(user!= null){
                       Navigator.pushReplacementNamed(context, 'mon',arguments: {'uid':identificador});
                    }
                  
                },
                    ),
          ),
          //  Container(
              
          //     child: ElevatedButton
          //     (
          //       child: const Text('ingresar'),
          //       onPressed: () async{
          //         User? user = await loginUsingEmailPassword(
          //           email: _emailController.text, 
          //           password: _passwordController.text, context: context);
          //           print(user);
          //           if(user!= null){
          //              Navigator.pushReplacementNamed(context, 'mon',arguments: {'uid':identificador});
          //           }
                  
          //       },
          //     ),
          //   ),
          
          Container(
               margin: const EdgeInsets.only(top: 30),
                width: 300,
                height: 48,
                child:ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[100],
                        side: const BorderSide(color: Colors.black38),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                          
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const[
                          // Icon(Icons.email ,color:ColorSelect.txtBoSubHe),
                          Text('Recuperar contraseña',
                          style: TextStyle(fontSize: 14,color: Colors.blueAccent),  
                        )
                        ],
        
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, 'reset');
                      },
                    ),
          ),
          Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: 300,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: const BorderSide(color: Colors.black38),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                          
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const[
                          // Icon(Icons.email ,color:ColorSelect.txtBoSubHe),
                          Text('Registrarse',
                          style: TextStyle(fontSize: 14,color: Colors.blueAccent),  
                        )
                        ],
        
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, 'register');
                      },
                    ),
                  ),
        ],
      ),
    );
  }
}
