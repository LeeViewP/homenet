import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Metric extends StatefulWidget {
  final DocumentSnapshot documentSnapshoot;

  Metric(this.documentSnapshoot,{this.isExpanded:false});
  bool isExpanded;
  @override
  MetricState createState() => new MetricState();
}

class MetricState extends State<Metric> {
  DocumentSnapshot document;
  bool pin;
  bool graph;
  String label;
  String value;
  String unit;
  DateTime updated;

  @override
  void initState() {
    super.initState();
    document = widget.documentSnapshoot;
    pin = document.data.containsKey('pin') ? document['pin'] : false;
    graph = document.data.containsKey('graph') ? document['graph'] : false;
    label = document.data.containsKey('label')
        ? document['label']
        : document.documentID;
    value =
        document.data.containsKey('value') ? document['value'].toString() : '0';
    unit = document.data.containsKey('unit') ? document['unit'] : '';
    updated = new DateTime.fromMillisecondsSinceEpoch(
        document.data.containsKey('updated') ? document['updated'] : '0');
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    document = widget.documentSnapshoot;
    pin = document.data.containsKey('pin') ? document['pin'] : false;
    graph = document.data.containsKey('graph') ? document['graph'] : false;
    label = document.data.containsKey('label')
        ? document['label']
        : document.documentID;
    value =
        document.data.containsKey('value') ? document['value'].toString() : '0';
    unit = document.data.containsKey('unit') ? document['unit'] : '';
    updated = new DateTime.fromMillisecondsSinceEpoch(
        document.data.containsKey('updated') ? document['updated'] : '0');
  }

  Widget build(BuildContext context) {
    var itemPadding = new EdgeInsets.only(
      right: 8.0,
    );
    var theme = Theme.of(context);
    return new Flex(direction: Axis.vertical,
        // decoration: new BoxDecoration(
        //             border: new Border( bottom: BorderSide(width: 1.0, color: Theme.of(context).disabledColor))
        //           ),
        children: [
          // const SizedBox(height: 24.0),
          new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new IconButton(
                alignment: Alignment.centerLeft,
                // padding: itemPadding,
                icon: new Icon(
                  pin ? MdiIcons.pinOutline : MdiIcons.pinOffOutline,
                  color:
                      pin ? theme.textTheme.button.color : theme.disabledColor,
                ),
                onPressed: () {
                                    setState(() =>
                      Firestore.instance.runTransaction((transaction) async {
                        DocumentSnapshot freshSnap =
                            await transaction.get(document.reference);
                        await transaction
                            .update(freshSnap.reference, {'pin': !pin});
                      }));
                },
              ),
              new IconButton(
                alignment: Alignment.centerLeft,
                // padding: itemPadding,
                icon: new Icon(
                  MdiIcons.chartLineVariant,
                  color: graph
                      ? theme.textTheme.button.color
                      : theme.disabledColor,
                ),
                onPressed: () {
                  setState(() =>
                      Firestore.instance.runTransaction((transaction) async {
                        DocumentSnapshot freshSnap =
                            await transaction.get(document.reference);
                        await transaction
                            .update(freshSnap.reference, {'graph': !graph});
                      }));
                },
              ),
              new Container(
                  // padding: itemPadding,
                  child: new Text(label,
                      style: Theme.of(context)
                          .textTheme
                          .subhead
                          .copyWith(fontWeight: FontWeight.normal))),
              new Expanded(
                  child: new Container(
                      alignment: Alignment.centerRight,
                      // padding: itemPadding,
                      // decoration: new BoxDecoration(
                      //   border: new Border.all()
                      // ),
                      child: new Text('$value$unit',
                          style: Theme.of(context)
                              .textTheme
                              .subhead
                              .copyWith(fontWeight: FontWeight.w800)))),
            ],
          ),
        ]);
  }

}
