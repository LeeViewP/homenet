import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "./sensoritem.dart";

class SensorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('sensors').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return new Center(
              child: new CircularProgressIndicator(
            value: null,
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ));
        return new GridView.count(
          crossAxisCount: 1,
          childAspectRatio: 2.6,
           mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          shrinkWrap: true,
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return new SensorCard(document);
          }).toList(),
        );
      },
    );
  }
}
