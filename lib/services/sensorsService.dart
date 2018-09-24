import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/sensorModel.dart';

class SensorService {
  final  CollectionReference collectionReference = Firestore.instance.collection('sensors');

  Future<List<SensorModel>> getAllSensors() async{
    QuerySnapshot snapshot = await collectionReference.getDocuments();
    return snapshot.documents.map((document){
      return new SensorModel(
        id: document.documentID,
        label: document.data.containsKey('label')?document['label']:document.documentID,
        descr: document.data.containsKey('descr')?document['descr']: '',
        type: document.data.containsKey('type')?document['type']: '',
        updated: new DateTime.fromMillisecondsSinceEpoch(
                    document.data.containsKey('updated')?document['updated']: 
                    DateTime.now().millisecondsSinceEpoch),
      );
    }).toList();
  }

  Future<void> delete(SensorModel sensor) async{
    //Delete the metrics first???
    
    await collectionReference.document(sensor.id).delete();

  }

  Future<Null> update<T>(String sensorId, String property, T value) async { 
    DocumentReference documentReference = collectionReference.document(sensorId);
    Firestore.instance.runTransaction((transaction) async{
      
      //Get Document snapshoot
        DocumentSnapshot freshSnapshoot = await transaction.get(documentReference);
            await transaction.update(freshSnapshoot.reference, {property: value});


          // if (freshSnapshoot.data['descr'].toString() != sensor.descr)
          //   await transaction.update(freshSnapshoot.reference, {'descr': sensor.descr});

          // if (freshSnapshoot.data['label'].toString() != sensor.label)
          //   await transaction.update(freshSnapshoot.reference, {'label': sensor.label});

          // if (freshSnapshoot.data['type'].toString() != sensor.type)
          //   await transaction.update(freshSnapshoot.reference, {'type': sensor.type});
    });
  }
void addChangesListener(fn){
  // CollectionReference reference =Firestore.instance.collection('sensors');
  collectionReference.snapshots().listen(fn);
}  
}