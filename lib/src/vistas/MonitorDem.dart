import 'package:flutter/material.dart';
import 'package:monitoreo/src/vistas/map_page.dart';


class MonitorDem extends StatefulWidget {
  MonitorDem({Key? key}) : super(key: key);

  @override
  State<MonitorDem> createState() => _MonitorDemState();
}

class _MonitorDemState extends State<MonitorDem> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('MonitorDem')),
      ),
      body: Column(
        children: [
          
          Container(
            height: height*0.5,
            color: Colors.pink,
            child: Center(child: MapPage(),)
          ),
          Container(
            color: Colors.yellow[200],
            height: height*0.397,
            child: const Center(child: Text('aqui van datos del tiempo, fecha y pulso ',style: TextStyle(color: Colors.black,fontSize: 20),),),)
        ],
      ),
    );
  }
}