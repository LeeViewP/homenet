import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/moteModel.dart';

class MotesService {
  final CollectionReference collectionReference =
      Firestore.instance.collection('motes');

  Future<List<MoteModel>> getAll() async {
    QuerySnapshot snapshot = await collectionReference.getDocuments();
    return snapshot.documents.map((document) {
      return new MoteModel(
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
