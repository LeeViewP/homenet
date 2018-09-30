import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsService {
  final CollectionReference collectionReference =
      Firestore.instance.collection('settings');

  Future<List<SettingsModel>> getAll() async {
    QuerySnapshot snapshot = await collectionReference
        .where('exposed', isEqualTo: true)
        .getDocuments();
    return snapshot.documents.map((document) {
      List<dynamic> list = new List<dynamic>();
      document.data.forEach((id, object) {
        if (object is! bool) {
          switch (object['type'] ?? 'text') {
            case 'text':
              list.add(new TextTypeSetting(
                  id,
                  object['exposed'] ?? true,
                  object['editable'] ?? true,
                  object['description'] ?? '',
                  value: object['value'] ?? ''));
              break;
            case 'password':
              list.add(new PasswordTypeSetting(
                  id,
                  object['exposed'] ?? true,
                  object['editable'] ?? true,
                  object['description'] ?? '',
                  value: object['value'] ?? ''));
              break;
            case 'email':
              list.add(new EmailTypeSetting(
                  id,
                  object['exposed'] ?? true,
                  object['editable'] ?? true,
                  object['description'] ?? '',
                  value: object['value'] ?? ''));
              break;
            case 'checkbox':
              list.add(new CheckBoxTypeSetting(
                  id,
                  object['exposed'] ?? true,
                  object['editable'] ?? true,
                  object['description'] ?? '',
                  value: object['value'] ?? false));
              break;
            case 'number':
              list.add(new NumberTypeSetting(
                  id,
                  object['exposed'] ?? true,
                  object['editable'] ?? true,
                  object['description'] ?? '',
                  value: object['value'] ?? 0.0));
              break;
            case 'range':
              list.add(new RangeTypeSetting(
                  id,
                  object['exposed'] ?? true,
                  object['editable'] ?? true,
                  object['description'] ?? '',
                  value: object['value'] ?? 0.0,
                  min: object['min'] ?? 0.0,
                  max: object['max'] ?? 0.0));
              break;
          }
        }
      });
      return new GroupSettingsModel(
        document.documentID,
        document['exposed'] ?? false,
        document['editable'] ?? false,
        children: list,
      );
    }).toList();
  }

  void addChangesListener(fn) {
    // CollectionReference reference =Firestore.instance.collection('sensors');
    collectionReference.snapshots().listen(fn);
  }
}


class SettingsModel {
  String id;
  bool exposed;
  bool editable;
  SettingsModel(this.id, this.exposed, this.editable);

}

class SettingsItem extends SettingsModel {
  String description;
  SettingsItem(String id, bool exposed, bool editable, this.description)
      : super(id, exposed, editable);
}

class TextTypeSetting extends SettingsItem {
  String value;
  TextTypeSetting(
      String id, bool exposed, bool editable, description, {this.value})
      : super(id, exposed, editable, description);
}

class PasswordTypeSetting extends SettingsItem {
  String value;
  PasswordTypeSetting(
      String id, bool exposed, bool editable, description, {this.value})
      : super(id, exposed, editable, description);
}

class EmailTypeSetting extends SettingsItem {
  String value;
  EmailTypeSetting(
      String id, bool exposed, bool editable, description, {this.value})
      : super(id, exposed, editable, description);
}

class CheckBoxTypeSetting extends SettingsItem {
  bool value;
  CheckBoxTypeSetting(
      String id, bool exposed, bool editable, description, {this.value})
      : super(id, exposed, editable, description);
}

class NumberTypeSetting extends SettingsItem {
  num value;
  NumberTypeSetting(
      String id, bool exposed, bool editable, description, {this.value})
      : super(id, exposed, editable, description);
}

class RangeTypeSetting extends SettingsItem {
  num value;
  num min;
  num max;

  RangeTypeSetting(String id, bool exposed, bool editable, description,
      {this.value, this.min, this.max})
      : super(id, exposed, editable, description);
}

class GroupSettingsModel extends SettingsModel{
   List<dynamic> children;
   bool isExpanded = false;
  GroupSettingsModel(String id, bool exposed, bool editable, {this.children})
      : super(id, exposed, editable);
}