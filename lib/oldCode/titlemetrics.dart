import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './titlemetric.dart';

class TitleMetrics extends StatelessWidget {
  const TitleMetrics({
    Key key,
    @required this.documentId,
    // @required this.descr,
  }) : super(key: key);

  final String documentId;
  // final String descr;
  //.where('pin', isEqualTo: true)
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('sensors')
          .document(documentId)
          .collection('metrics')
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
            // decoration: BoxDecoration(
            //     border: new Border.all(color: Theme.of(context).primaryColor)),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                   if (document.documentID =='V' || document.documentID == 'RSSI')
                      return new TitleMetric(document);
                     else return  new Container();
              }).toList(),
            ));
      },
    );
  }
}