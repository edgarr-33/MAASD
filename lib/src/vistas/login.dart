import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  // Codigo correcto
  final _user = TextEditingController();
  final _password = TextEditingController();
  late String _name;
  late String _passw;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String usuario = "user";
    String pass = "user123";

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('MonitorDem')
        ),
      ),
      body: Column(
        children: [
          Image.asset('assets/logo.png',),
          Container(
            width: width * 0.8,
            height: height * 0.1,
            margin: const EdgeInsets.only(top: 50),
            child: TextField(
              controller: _user,
              decoration: const InputDecoration(
                labelText: 'Usuario',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            width: width * 0.8,
            height: height * 0.1,
            margin: const EdgeInsets.only(top: 50),
            child: TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                // hintText: 'Contraseña'
              ),
            ),
          ),
          Center(
            child: Container(
              child: ElevatedButton(
                child: const Text('ingresar'),
                onPressed: () {
                  _name = _user.text;
                  _passw = _password.text;
                  if (_name == usuario && _passw == pass) {
                    Navigator.pushReplacementNamed(context, 'splash');
                  }
                },
              ),
            ),
          )
        ],
      )          
    );
  }
}
