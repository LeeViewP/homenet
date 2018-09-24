import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import './metric.dart';
import './metricExpanded.dart';

class Metrics extends StatefulWidget {
  final DocumentSnapshot documentSnapshoot;

  Metrics(this.documentSnapshoot);
  bool isExpanded;
  @override
  MetricsState createState() => new MetricsState();
}

class MetricsState extends State<Metrics> {
  DocumentSnapshot document;
  List<MetricItem> _items; // = new List<MetricItem>();
  StreamController<QuerySnapshot> _streamController =
      new StreamController<QuerySnapshot>.broadcast();

  bool refreshList;
  @override
  void initState() {
    super.initState();
    document = widget.documentSnapshoot;
    _items = new List<MetricItem>();
    refreshList = true;
    _streamController.addStream(Firestore.instance
        .collection('sensors')
        .document(document.documentID)
        .collection('metrics')
        .snapshots());
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    document = widget.documentSnapshoot;
    // refreshList = true;
  }

  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
        stream: _streamController.stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return new Center(
                child: new CircularProgressIndicator(
              value: null,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ));
          if (refreshList)
            this._items =
                snapshot.data.documents.map((DocumentSnapshot document) {
              var pin =
                  document.data.containsKey('pin') ? document['pin'] : false;
              var graph = document.data.containsKey('graph')
                  ? document['graph']
                  : false;
              var label = document.data.containsKey('label')
                  ? document['label']
                  : document.documentID;
              var value = document.data.containsKey('value')
                  ? document['value'].toString()
                  : '0';
              var unit =
                  document.data.containsKey('unit') ? document['unit'] : '';
              var updated = new DateTime.fromMillisecondsSinceEpoch(
                  document.data.containsKey('updated')
                      ? document['updated']
                      : '0');
              return new MetricItem<String>(
                graph: graph,
                label: label,
                hint: 'Change metric name',
                pin: pin,
                unit: unit,
                updated: updated,
                value: value,
                valueForEdit: label,
                valueToString: (String value) => value,
                pinOnPressed: () {
                  setState(() =>
                      Firestore.instance.runTransaction((transaction) async {
                        DocumentSnapshot freshSnap =
                            await transaction.get(document.reference);
                        await transaction
                            .update(freshSnap.reference, {'pin': !pin});
                      }));
                },
                graphOnPressed: () {
                  setState(() =>
                      Firestore.instance.runTransaction((transaction) async {
                        DocumentSnapshot freshSnap =
                            await transaction.get(document.reference);
                        await transaction
                            .update(freshSnap.reference, {'graph': !graph});
                      }));
                },
                builder: (MetricItem<String> item) {
                  void close() {
                    setState(() {
                      refreshList = true;
                      item.isExpanded = false;
                    });
                  }

                  return Form(
                    child: Builder(
                      builder: (BuildContext context) {
                        return CollapsibleBody(
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          onSave: () {
                            Form.of(context).save();
                            close();
                          },
                          onCancel: () {
                            Form.of(context).reset();
                            close();
                          },
                          onDelete: () async {
                            // Future<Null> _askedToLead() async {
                            switch (await showDialog<DialogOptions>(
                                context: context, builder: _buildAlert)) {
                              case DialogOptions.AGREE:
                                Firestore.instance
                                    .runTransaction((transaction) async {
                                  DocumentSnapshot freshSnap =
                                      await transaction.get(document.reference);
                                  await transaction.delete(freshSnap.reference);
                                });
                                Form.of(context).reset();
                                close();
                                break;
                              case DialogOptions.DISAGREE:
                                break;
                            }
                            // };
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: TextFormField(
                              controller: item.textController,
                              decoration: InputDecoration(
                                  border: new OutlineInputBorder(),
                                  hintText: item.hint,
                                  labelText: 'Metric label' //item.label,
                                  ),
                              // autofocus: true,
                              onSaved: (String value) {
                                Firestore.instance
                                    .runTransaction((transaction) async {
                                  DocumentSnapshot freshSnap =
                                      await transaction.get(document.reference);
                                  await transaction.update(
                                      freshSnap.reference, {'label': value});
                                });
                                // item.valueForEdit = value;
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
              // return new MyItem(headerWidget: new Metric(document));
            }).toList();
          return new Flex(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              direction: Axis.vertical,
              children: [
                new ExpansionPanelList(
                    //  animationDuration: Duration(seconds: 10),
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        refreshList = isExpanded;
                        _items[index].isExpanded = !_items[index].isExpanded;
                      });
                    },
                    children: _items.map((MetricItem<dynamic> item) {
                      return ExpansionPanel(
                          isExpanded: item.isExpanded,
                          headerBuilder: item.headerBuilder,
                          body: item.build());
                    }).toList()
                    // .map((MyItem item) {
                    //   return new ExpansionPanel(
                    //       headerBuilder: (BuildContext context, bool isExpanded) {
                    //         return item.headerWidget;
                    //       },
                    //       isExpanded: item.isExpanded,
                    //       body: new Container(
                    //         child: new Text(
                    //             item.headerWidget.documentSnapshoot.documentID),
                    //       ));
                    // }).toList(),
                    ),
              ]
              //     snapshot.data.documents.map((DocumentSnapshot document) {
              //   return new Metric(document);
              // }).toList(),
              );
        });
  }

  Widget _buildAlert(BuildContext context) {
    return new AlertDialog(
        title: const Text('Remove this metric?'),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text(' Stored metric data will be kept (if any).'),
              new Text(
                  'Further data from this node-metric will make it appear again.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
              child: const Text('DISAGREE'),
              onPressed: () {
                Navigator.pop(context, DialogOptions.DISAGREE);
              }),
          FlatButton(
              child: const Text('AGREE'),
              onPressed: () {
                Navigator.pop(context, DialogOptions.AGREE);
              })
        ]);
  }
}

// class MyItem {
//   MyItem({this.isExpanded: false, this.headerWidget, this.body});

//   bool isExpanded;
//   Metric headerWidget;
//   Widget body;
// }
