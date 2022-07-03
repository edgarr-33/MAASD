import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ResetPass extends StatefulWidget {
  ResetPass({Key? key}) : super(key: key);

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  
final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar contraseña')),
      body: SafeArea(
        child: GestureDetector(
          onTap: ()=> FocusScope.of(context).unfocus(),
          child: Container(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            color: Colors.transparent,
            child: Column(
              children: [
  
              TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              // onPressed: ()=>_sumbit(context,_emailController.text),
              onPressed: resetPassword,
               child: const Text('enviar'))
              ],
            ),
          ),
        ),
      )
    );
  }


  void _sumbit(BuildContext context, String mail)async{
     
     
  }
  

  Future resetPassword() async{
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(),)
      );

    
    try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
    const SnackBar(content: Text('Password Reset Email Sent'));
     Navigator.pushReplacementNamed(context, 'InitialPage');
  }on FirebaseAuthException catch(e){
    print(e);
    SnackBar(content: Text("${e.message}"));
    Navigator.of(context).pop();
  }
  }
} 