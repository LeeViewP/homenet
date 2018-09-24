import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './pinnedmetrics.dart';
import './titlemetrics.dart';
import './sensordetails.dart';

class SensorCard extends StatefulWidget {
  final DocumentSnapshot documentSnapshoot;
  SensorCard(this.documentSnapshoot);
  @override
  SensorCardState createState() => new SensorCardState();
}

class SensorCardState extends State<SensorCard> {
  DocumentSnapshot document;
  @override
  void initState() {
    super.initState();
    document = widget.documentSnapshoot;
  }

  void _handleTap() {
    setState(() {
      document = widget.documentSnapshoot;
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) =>
                  new SensorDetails(widget.documentSnapshoot)));
      //  Navigator.of(context).pushNamed(SensorDetails.routeName);
    });
  }

  Widget build(BuildContext context) {
    var label = widget.documentSnapshoot.data.containsKey('label')
        ? widget.documentSnapshoot['label']
        : '';
    var type = widget.documentSnapshoot.data.containsKey('type')
        ? widget.documentSnapshoot['type']
        : '';
    var descr = widget.documentSnapshoot.data.containsKey('descr')
        ? widget.documentSnapshoot['descr']
        : '';
    var updated = new DateTime.fromMillisecondsSinceEpoch(
        widget.documentSnapshoot.data.containsKey('updated')
            ? widget.documentSnapshoot['updated']
            : '0');

    Row _buildTitle(String label, String descr, IconData icon) {
      var textPadding  = const EdgeInsets.only(left:8.0, top:2.0,bottom: 2.0 );
      var metricTitlePadding  = const EdgeInsets.only(right:8.0, top:2.0,bottom: 2.0 );
      var imagePadding  = const EdgeInsets.only(right:16.0, top:2.0,bottom: 2.0 );
      return new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                         new Container(
            margin: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 8.0,
            ),
            child: new Icon(null, size:Theme.of(context).textTheme.subhead.fontSize),
          ),
              new Container(
                alignment: Alignment.centerLeft,
                padding: textPadding,
                child: new Text(label,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left),
              ),
              new Container(
                alignment: Alignment.centerLeft,
                padding: textPadding,
                child: new Text(descr,
                    style: new TextStyle(
                      color: Theme.of(context).disabledColor,
                    ),
                    textAlign: TextAlign.left),
              ),
            ],
          ),
          new Expanded(
            child: 
           new Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Container(
                alignment: Alignment.centerRight,
                padding: metricTitlePadding,
                child: new TitleMetrics(
                    documentId: widget.documentSnapshoot.documentID),
              ),
          
            new Container(
              alignment: Alignment.centerRight,
              padding: imagePadding,
              child: new Icon(icon, size:Theme.of(context).textTheme.display1.fontSize,),
            ),
          // ),
          ]
          ),)
        ],
      );
    }

    return new GestureDetector(
        onTap: _handleTap,
        child: new Card(
            key: new ValueKey(widget.documentSnapshoot.documentID),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildTitle(label, descr, Icons.desktop_mac),
                new Container(
                  padding:const EdgeInsets.only(top:8.0,bottom:8.0),
                  child: new PinnedMetrics(
                      documentId: widget.documentSnapshoot.documentID),
                ),
              ],
            )));
  }
}
