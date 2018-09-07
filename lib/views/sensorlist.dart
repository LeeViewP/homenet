import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SensorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('nothing').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Center(child: new Text('Loading...'));
        return new ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return new Card(
                key: new ValueKey(document.documentID),
                child: new ListTile(
                  leading: new Icon(Icons.ac_unit),
                  title: new Text(document['name']), 
                  subtitle: new Text(document['description']),
                ));
          }).toList(),
        );
      },
    );
  }
}


