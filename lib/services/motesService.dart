import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';


class MotesService {
  final CollectionReference collectionReference =
      Firestore.instance.collection('motes');

  Future<List<Mote>> getAll() async {
    QuerySnapshot snapshot = await collectionReference.getDocuments();
    return snapshot.documents.map((document) {
      return new Mote(
        id: document.documentID,
        icon: document['icon'] ?? '',
        label: document['label'] ?? '',
      );
    }).toList();
  }

  void addChangesListener(fn) {
    // CollectionReference reference =Firestore.instance.collection('sensors');
    collectionReference.snapshots().listen(fn);
  }
}

class Mote {
  String id;
  String icon;
  String label;
  Mote({this.id, this.icon, this.label});
}
