import 'package:flutter/material.dart';
import '../services/sensorsService.dart';
import '../model/sensorModel.dart';

class SensorsViewModel extends StatefulWidget {
  static String routeName = '/SensorsViewModel';
  @override
  SensorsViewModelState createState() => new SensorsViewModelState();
}

class SensorsViewModelState extends State<SensorsViewModel> {
  SensorService sensorService = new SensorService();
  List<SensorModel> sensors;
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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.all(24.0),
        child: new ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              new SensorViewModelItemItem(sensors[index]),
          itemCount: sensors == null ? 0 : sensors.length,
        ));
  }
}

class SensorViewModelItemItem extends StatelessWidget {
  SensorViewModelItemItem(this.sensorModel);
  final SensorModel sensorModel;

  @override
  Widget build(BuildContext context) {
    return new Card(
        child: new ListTile(
      title: new Text(sensorModel.label),
      subtitle: new Text(sensorModel.descr),
    ));
  }
}
