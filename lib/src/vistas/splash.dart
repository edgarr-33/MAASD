import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'MonitorDem.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  ui.Image? image;

  @override
  void initState() {
    super.initState();
    _loadImage('assets/icono.png');
    _toOnBording();
  }
 List<double> latList=[];
  List<double> longList=[];

  @override
  Widget build(BuildContext context) {
  final arguments = ModalRoute.of(context)!.settings.arguments as Map;
  String identificador = arguments['uid'];


  Future<void> getUserById(String identificador) async {
    List<dynamic> coords = [];
    
    
    await FirebaseFirestore.instance.collection('users').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc.id == identificador) {
          // print(doc['coords']);
          coords.add(doc['coords']);
        }
      });
    });
    // print('...............................');
    // print(coords);
    for (var i = 0; i < coords[0].length; i++) {
      
      latList.add(coords[0][i].latitude);
      longList.add(coords[0][i].longitude);
    }
  }
    getUserById(identificador);




    return Scaffold(
      body: Center(
        child: SizedBox(
          child: CustomPaint(
            painter: _SplashScreanCanvas(image),
          ),
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }

  _toOnBording() async {
    // print(object)
    print(latList);
    print(longList);
    await Future.delayed(const Duration(milliseconds: 5000), (){}); //5
    
    Navigator.pushReplacement(
      context, MaterialPageRoute(
        builder: (context) => MonitorDem()
      )
    );
  }

  void _loadImage(String s) async {
    final data = await rootBundle.load(s);
    final bytes = data.buffer.asUint8List();
    final image = await decodeImageFromList(bytes);
    setState(() {
      this.image = image;
    });
  }
} 

class _SplashScreanCanvas extends CustomPainter {

  ui.Image? imageCanvas;
  _SplashScreanCanvas(this.imageCanvas);

  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint();
    paint.color = Color.fromARGB(255, 158, 195, 236);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5;

    final path = Path();
    path.lineTo(0, size.height*0.1);
    path.quadraticBezierTo(size.width*0.1, size.height * 0.2, size.width/3, size.height*0.15);
    path.quadraticBezierTo(size.width/2.1, size.height * 0.1, (size.width/3)*2, size.height*0.12);
    path.quadraticBezierTo(size.width/1.1, size.height * 0.15, (size.width/3)*3, size.height*0.12);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);

    final paint2 = Paint();
    paint2.color =const Color.fromARGB(255, 158, 195, 236);
    paint2.style = PaintingStyle.fill;
    paint2.strokeWidth = 5;

    final path2 = Path();
    path2.lineTo(0, size.height);
    path2.quadraticBezierTo(size.width*0.75, size.height*0.80, size.width, size.height);
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);

    canvas.drawPath(path2, paint2);
    canvas.scale(0.30,0.30);
    canvas.drawImage(imageCanvas!, const Offset(140 * 3, 320 * 3.0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}