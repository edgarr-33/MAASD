import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // 1. Nombre completo
  // 2. Correo
  // 3. Contraseña 
  // 4. Confirmar Contraseña
  final _user = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  late String _name;
  late String _mail;
  late String _passw;
  String password = '';
  bool isPasswordVisible = false;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.grey,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text(
          'Regístrate',
          style: TextStyle(fontSize: 20),
        )
      ),
      body: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
        width: size.width,
        height: size.height ,
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Inputs
              layoutView(size.width, size.height),
              // Boton
              button(),
              // Iniciar sesion
              finalText(context)
            ],
          ),
        ),
      )
    );
  }

  Container layoutView(double width, double height) {
    return Container(
      width: double.infinity,
      // height: 415,
      color: Colors.transparent,
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          // Text Name
          texts('Nombre'),
          // TextFile Name Full
          inputs('Nombre completo', height, _user),
          // Text Addres
          texts('Correo electrónico'),
          // TextFile Addres
          inputs('Dirección de correo', height, _email),
          // Text Password
          texts('Contraseña'),
          // TextField Password
          passwords('Contraseña', height, _password),
          // Text Confirm Password
          texts('Confirmar contraseña'),
          // TextField Password
          passwords('Confirmar contraseña', height, _confirmPassword),
          // Text Area
          texts('Delimitar área'),
          // Obtener coordenadas
          getCoordinates(),
        ],
      ),
    );
  }

  Container getCoordinates() {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      width: double.infinity,
      height: 50,
      color: Colors.transparent,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blueGrey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
          )
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'delimit');
        },
        child: const Text(
          'Delimirar área',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54
          ),
        ),
      ),
    );
  }

  Container texts (String nombre) {
    return Container(
      width: double.infinity,
      // height: 30,
      color: Colors.transparent,
      child: Text(
        nombre, 
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15
        ),
        textAlign: TextAlign.left,
      )
    );
  }

  Container inputs (String nombre, double height, controllerV) {
    return Container(
      width: double.infinity,
      height: height * 0.1,
      margin: const EdgeInsets.only(top: 5),
      child: TextField(
        controller: controllerV,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: nombre,
        ),
      ),
    );
  }

  Widget passwords (String nombre, double height, password) {
    return Container(
      width: double.infinity,
      height: height * 0.1,
      margin: const EdgeInsets.only(top: 5),
      child: TextField(
        onChanged: (value) => setState(() => this.password = value),
        onSubmitted: (value) => setState(() => this.password = value),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: nombre,
          suffixIcon: IconButton(
            icon: isPasswordVisible
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
            onPressed: () => setState(() => isPasswordVisible =  !isPasswordVisible ),
          ),
          border: const OutlineInputBorder(),
        ),
        obscureText: isPasswordVisible,
      ),
    );
  }

  Container button() {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(top: 100),
      color: Colors.transparent,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
          )
        ),
        onPressed: () {},
        child: const Text(
          'Crear Cuenta',
          style: TextStyle(
            fontSize: 18
          ),
        ),
      ),
    );
  }

  Container finalText(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '¿Ya tienes cuenta? ',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, 'iniciarSesion');
            },
            child: const Text(
              'Iniciar Sesión',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            )
          )
        ],
      ),
    );
  }
}