import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './pinnedmetric.dart';

class PinnedMetrics extends StatelessWidget {
  const PinnedMetrics({
    Key key,
    @required this.documentId,
    // @required this.descr,
  }) : super(key: key);

  final String documentId;
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('sensors')
          .document(documentId)
          .collection('metrics')
          .where('pin', isEqualTo: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return new Center(
              child: new CircularProgressIndicator(
            value: null,
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ));
        return new Container(
            child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return new PinnedMetric(document); 
          }).toList(),
        ));
      },
    );
  }
}

class VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => RotatedBox(
        quarterTurns: 1,
        child: new Divider(),
      );
}
