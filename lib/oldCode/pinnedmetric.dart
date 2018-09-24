import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PinnedMetric extends StatefulWidget {
  final DocumentSnapshot documentSnapshoot;

  PinnedMetric(this.documentSnapshoot);
  
  @override
  PinnedMetricState createState() => new PinnedMetricState();
}

class PinnedMetricState extends State<PinnedMetric> {
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
    
    Row _buildMetricAsText (String label, String unit, DateTime lastActivity) {
      //Color color = Theme.of(context).primaryColor;
      double fontSize = Theme.of(context).textTheme.caption.fontSize;
      return new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Container(
            margin: const EdgeInsets.only(top: 8.0, bottom: 8.0, left:8.0,),
            child: Text(
              label,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                // color: color,
              ),
            ),
          ),
          new Container(
            margin: const EdgeInsets.only( top:8.0, bottom: 8.0,right:8.0,),
            child: Text(
              unit,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                // color: color,
              ),
            ),
          )
        ],
      );
    }

    Row _buildMetricAsIcon( IconData icon, DateTime lastActivity){
      return new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Container(
            margin: const EdgeInsets.only(top: 8.0, bottom: 8.0, left:8.0,),
            child:new Icon(icon, size:Theme.of(context).textTheme.caption.fontSize),
            )
          ,
        ],
      );
    }

  
  Color color = Theme.of(context).primaryColor;
    var label =  widget.documentSnapshoot.data.containsKey('label') ?  widget.documentSnapshoot['label'] : '';
    // value =  widget.documentSnapshoot.data.containsKey('value') ?   widget.documentSnapshoot['value'].toString() : '';
    var unit =  widget.documentSnapshoot.data.containsKey('unit') ?  widget.documentSnapshoot['unit'] : '';
    var updated = new DateTime.fromMillisecondsSinceEpoch(
         widget.documentSnapshoot.data.containsKey('updated') ?  widget.documentSnapshoot['updated'] : '0');
    var graph =  widget.documentSnapshoot.data.containsKey('graph') ?  widget.documentSnapshoot['graph'] : false;
    var pin =  widget.documentSnapshoot.data.containsKey('pin') ?  widget.documentSnapshoot['pin'] : false;
    var documentID = widget.documentSnapshoot.documentID;
    var value =  widget.documentSnapshoot.data.containsKey('value') ?   widget.documentSnapshoot['value'].toString() : '0';
    if(documentID=='M')
      return _buildMetricAsIcon( MdiIcons.runFast,updated);
    return _buildMetricAsText(value.toString(), unit, updated);
    
    
  }
}
