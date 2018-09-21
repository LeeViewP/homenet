import 'package:flutter/material.dart';
import './sensorlist.dart';

class SensorView extends StatefulWidget {
  static String routeName = '/sensorView';
  @override
  SensorViewState createState() => new SensorViewState();
}

class SensorViewState extends State<SensorView> {
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var titleTextStyle = new TextStyle(fontSize: theme.textTheme.title.fontSize, color:theme.primaryColor );
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0.0,
        title: new Text('Sensors',style: titleTextStyle,),
        iconTheme: IconThemeData( color: theme.primaryColor),
      ),
      body: SensorList(),
    );
  }
}
