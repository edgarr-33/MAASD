import 'package:flutter/material.dart';

class Alerta extends StatefulWidget {
  Alerta({Key? key}) : super(key: key);

  @override
  State<Alerta> createState() => _AlertaState();
}

class _AlertaState extends State<Alerta> {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: AlertDialog(
          title: const Text('data',style: TextStyle(fontSize: 30),),
          content: const Text('data',style: TextStyle(fontSize: 30)),
          actions: [
            ElevatedButton(
              onPressed:(){
                  
              },
               child: const Text('Enterado'))
          ],
      ),
    );
  }
}