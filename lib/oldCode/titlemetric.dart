import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TitleMetric extends StatefulWidget {
  final DocumentSnapshot documentSnapshoot;

  TitleMetric(this.documentSnapshoot);

  @override
  TitleMetricState createState() => new TitleMetricState();
}

class TitleMetricState extends State<TitleMetric> {
  DocumentSnapshot documentSnapshot;
  String label;
  // String value;
  String unit;
  DateTime updated;
  bool pin;
  bool graph;
  String documentID;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    Row _buildMetricAsIcon(IconData icon, DateTime lastActivity) {
      return new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Container(
            margin: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 8.0,
            ),
            child: new Icon(icon, size:Theme.of(context).textTheme.subhead.fontSize),
          ),
        ],
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
    }

    Color color = Theme.of(context).primaryColor;
    // var label =  widget.documentSnapshoot.data.containsKey('label') ?  widget.documentSnapshoot['label'] : '';
    // value =  widget.documentSnapshoot.data.containsKey('value') ?   widget.documentSnapshoot['value'].toString() : '';
    var unit =  widget.documentSnapshoot.data.containsKey('unit') ?  widget.documentSnapshoot['unit'] : '';
    var updated = new DateTime.fromMillisecondsSinceEpoch(
        widget.documentSnapshoot.data.containsKey('updated')
            ? widget.documentSnapshoot['updated']
            : '0');
    // var graph =  widget.documentSnapshoot.data.containsKey('graph') ?  widget.documentSnapshoot['graph'] : false;
    // var pin =  widget.documentSnapshoot.data.containsKey('pin') ?  widget.documentSnapshoot['pin'] : false;
    var documentID = widget.documentSnapshoot.documentID;
    var value = widget.documentSnapshoot.data.containsKey('value')
        ? widget.documentSnapshoot['value'].toString()
        : 0;
    if (documentID == 'RSSI')
      return _buildMetricAsIcon(_buildRssiIcon(value), updated);
    else
      return _buildMetricAsIcon(_buildBatteryIcon(value), updated);
  }
}
