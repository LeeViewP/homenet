import 'package:flutter/material.dart';

import './loadingView.dart';
import './sensorCard.dart';
import '../model/sensorModel.dart';
import '../services/sensorsService.dart';

class SensorsView extends StatefulWidget {
  static String routeName = '/sensorsView';
  @override
  SensorsViewState createState() => new SensorsViewState();
}

class SensorsViewState extends State<SensorsView> {
   SensorService sensorService = new SensorService();
  List<SensorModel> sensors;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    sensorService.addChangesListener((snapshot) {
      updateSensors();
    });
   
  }

  void updateSensors() {
    sensorService.getAllSensors().then((sensors) {
      setState(() {
        this.sensors = sensors;
        _isLoading =false;
      });
    });
  }

  Widget build(BuildContext context) {
     if(_isLoading) return new LoadingView(title:'Sensors');

    var theme = Theme.of(context);
    var titleTextStyle = new TextStyle(fontSize: theme.textTheme.title.fontSize, color:theme.primaryColor );

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0.0,
        title: new Text('Sensors',style: titleTextStyle,),
        iconTheme: IconThemeData( color: theme.primaryColor),
      ),
      body: new Container(
        margin: const EdgeInsets.all(4.0),
        child: new ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              new SensorCard(sensors[index]),
          itemCount: sensors == null ? 0 : sensors.length,
        )),
    );
  }
}
