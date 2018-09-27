import 'package:flutter/material.dart';
import 'package:homenet/businesslogic/sensorsBusinessLogic.dart';
import 'package:homenet/businesslogic/sensorBusinessLogic.dart';

// import 'package:ehabitat/views/drawerhomenet.dart';
class SettingsView extends StatefulWidget {
  static String routeName = '/settingsView';
  @override
  SettingsViewState createState() => new SettingsViewState();
}

class SettingsViewState extends State<SettingsView> {
  SensorsBusinessLogic allsensors;
  List<SensorBusinessLogic> sensors;
 @override
  void initState() {
     super.initState();
allsensors = new SensorsBusinessLogic();
   sensors= allsensors.sensors;
   
  }
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var titleTextStyle = new TextStyle(
        fontSize: theme.textTheme.title.fontSize, color: theme.primaryColor);
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Settings',
          style: titleTextStyle,
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: theme.primaryColor),
      ),
      body: new ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
              new ListTile(title: new Text(sensors[index].description)),
          itemCount: sensors == null ? 0 : sensors.length,
          // itemBuilder: allsensors.sensors.map(
          //     (SensorBusinessLogic sensor){ return new ListTile(title: new Text(sensor.Id));}
          //     )
          )
      // new Center(
      //     child: new LinearProgressIndicator(
      //   value: null,
      //   valueColor:
      //       AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
      // )),
      // drawer: HomeNetDrawer(),
    );
  }
}
