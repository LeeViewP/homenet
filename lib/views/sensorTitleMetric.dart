import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../model/metricModel.dart';

class SensorTitleMetric extends StatelessWidget {
  SensorTitleMetric(this.metricModel);
  final MetricModel metricModel;

  @override
  Widget build(BuildContext context) {
     Widget _buildMetricAsIcon(IconData icon, DateTime lastActivity) {
      return 
      // new Row(
      //   mainAxisSize: MainAxisSize.min,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: ['
          new Container(
            margin: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 8.0,
            ),
            child: new Icon(icon, size:Theme.of(context).textTheme.subhead.fontSize),
        //   ),
        // ],
      );
    }

    IconData _buildRssiIcon(String value) {
      var intValue = num.tryParse(value);
      if (intValue != null) {
        IconData img = MdiIcons.wifiOff;
        if (intValue.abs() > 95)
          img = MdiIcons.wifiStrengthOutline;
        else if (intValue.abs() > 90)
          img = MdiIcons.wifiStrength1;
        else if (intValue.abs() > 80)
          img = MdiIcons.wifiStrength2;
        else if (intValue.abs() > 70)
          img = MdiIcons.wifiStrength3;
        else
          img = MdiIcons.wifiStrength4;

        return img;
      }
      return null;
    }

    IconData _buildBatteryIcon(String value) {
      var voltage = double.tryParse(value);
      if (voltage != null) {
        IconData img = MdiIcons.batteryAlert;
        if (voltage < 3.35)
          img = MdiIcons.batteryAlert;
        else if (voltage < 3.45)
          img = MdiIcons.battery10;
        else if (voltage < 3.55)
          img = MdiIcons.battery20;
        else if (voltage < 3.65)
          img = MdiIcons.battery30;
        else if (voltage < 3.75)
          img = MdiIcons.battery40;
        else if (voltage < 3.85)
          img = MdiIcons.battery50;
        else if (voltage < 3.95)
          img = MdiIcons.battery60;
        else if (voltage < 4.05)
          img = MdiIcons.battery70;
        else if (voltage < 4.15)
          img = MdiIcons.battery80;
        else if (voltage < 4.25)
          img = MdiIcons.battery90;
        else
          img = MdiIcons.battery;
        return img;
      }
      return null;
    }
    //Color color = Theme.of(context).primaryColor;
    if (metricModel.id == 'RSSI')
      return  
        new GestureDetector(
            child: _buildMetricAsIcon(_buildRssiIcon(metricModel.value), metricModel.updated),
            onTap: (){
                      showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
                var title = metricModel.label;
        var value = metricModel.value;
        return AlertDialog(
          title: new Text("Alert Dialog $title"),
          content: new Text("$value"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
            },);}
        );
    else
      return  
        new GestureDetector(
          child: _buildMetricAsIcon(_buildBatteryIcon(metricModel.value), metricModel.updated),
                      onTap: (){
                      showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        var title = metricModel.label;
        var value = metricModel.value;
        return AlertDialog(
          title: new Text("Alert Dialog $title"),
          content: new Text("$value"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
            },);}
        );
  }
}