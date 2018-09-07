import 'package:flutter/material.dart';
import './drawerhomenet.dart';
import './sensorlist.dart';

class SensorView extends StatefulWidget {
  static String routeName = '/sensorView';
  @override
  SensorViewState createState() => new SensorViewState();
}

class SensorViewState extends State<SensorView> {
 Widget build(BuildContext context) {
          return Scaffold ( 
          appBar: new AppBar(
            title: new Text('Sensors'),

          ),
          body: SensorList(),
          // body: new Center(
          //   child:new Text("Sensors View"),
          //   ),
           drawer: HomeNetDrawer(),
          );
 }
}