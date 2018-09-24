import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/metricModel.dart';

class MetricsService {
  Future<List<MetricModel>> getMetrics(String sensorId) async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('sensors')
        .document(sensorId)
        .collection('metrics')
        .getDocuments();
    return querySnapshot.documents.map((document) {
      return new MetricModel(
        id: document.documentID,
        pin: document.data.containsKey('pin') ? document['pin'] : false,
        graph: document.data.containsKey('graph') ? document['graph'] : false,
        label: document.data.containsKey('label')
            ? document['label']
            : document.documentID,
        value: document.data.containsKey('value')
            ? document['value'].toString()
            : '0',
        unit: document.data.containsKey('unit') ? document['unit'] : '',
        updated: new DateTime.fromMillisecondsSinceEpoch(
            document.data.containsKey('updated')
                ? document['updated']
                : DateTime.now().millisecondsSinceEpoch),
      );
    }).toList();
  }

  Future<void> delete(String sensorId, String metricId) async {
    CollectionReference collectionReference = Firestore.instance
        .collection('sensors')
        .document(sensorId)
        .collection('metrics');
    await collectionReference.document(metricId).delete();
  }

  Future<void> update<T>(String sensorId, String metricId, String property, T value) async {
    CollectionReference collectionReference = Firestore.instance
        .collection('sensors')
        .document(sensorId)
        .collection('metrics');
     DocumentReference documentReference = collectionReference.document(metricId);
    Firestore.instance.runTransaction((transaction) async{
      //Get Document snapshoot
        DocumentSnapshot freshSnapshoot = await transaction.get(documentReference);
        await transaction.update(freshSnapshoot.reference,{property:value}); 
    });
  }

  void addChangesListener(String sensorId, fn){
      CollectionReference collectionReference = Firestore.instance
        .collection('sensors')
        .document(sensorId)
        .collection('metrics');
  collectionReference.snapshots().listen(fn);
}  
}
