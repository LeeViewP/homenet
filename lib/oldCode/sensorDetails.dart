import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import './metrics.dart';

class SensorDetails extends StatefulWidget {
  static String routeName = '/SensorDetails';
  final DocumentSnapshot documentSnapshoot;
  SensorDetails(this.documentSnapshoot);
  @override
  SensorDetailsState createState() => new SensorDetailsState();
}

class SensorDetailsState extends State<SensorDetails> {
  DocumentSnapshot document;
  DateTime updated;
  TextEditingController idController;
  TextEditingController labelController;
  TextEditingController descrController;
  TextEditingController typeController;
  bool showSave;
 
  String label;
  String descr;
  String type;

  @override
  void initState() {
    super.initState();

    showSave = false;
    document = widget.documentSnapshoot;
    updated = new DateTime.fromMillisecondsSinceEpoch(
        document.data.containsKey('updated') ? document['updated'] : '0');
    idController = new TextEditingController(text: document.documentID);
    labelController = new TextEditingController(
        text: document.data.containsKey('label') ? document['label'] : '');
    labelController.addListener(_somethingChanged);
    descrController = new TextEditingController(
        text: document.data.containsKey('descr') ? document['descr'] : '');
    descrController.addListener(_somethingChanged);
    typeController = new TextEditingController(
        text: document.data.containsKey('type') ? document['type'] : '');
    typeController.addListener(_somethingChanged);
  }

  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    document = widget.documentSnapshoot;
    updated = new DateTime.fromMillisecondsSinceEpoch(
        document.data.containsKey('updated') ? document['updated'] : '0');
    if (!showSave) {
      labelController.text =
          document.data.containsKey('label') ? document['label'] : '';
      descrController.text =
          document.data.containsKey('descr') ? document['descr'] : '';
      typeController.text =
          document.data.containsKey('type') ? document['type'] : '';
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    labelController.removeListener(_somethingChanged);
    labelController.dispose();
    idController.dispose();
    descrController.removeListener(_somethingChanged);
    descrController.dispose();
    typeController.removeListener(_somethingChanged);
    typeController.dispose();
    super.dispose();
  }

  _somethingChanged() {
    setState(() {
      showSave = true;
    });
  }

  Widget build(BuildContext context) {
    var paddings = const EdgeInsets.symmetric(horizontal: 16.0);

  Widget _buildTextBox(
        String label, String hint, TextEditingController controller,
        [ValueChanged<String> onsubmited = null,
        bool enabled = true,
        bool autofocus = false]) {
      return new Container(
          child: new TextField(
        decoration: new InputDecoration(
          border: new OutlineInputBorder(),
          labelText: label,
          hintText: hint,
          enabled: enabled,
        ),
        controller: controller,
        autofocus: autofocus,
        onSubmitted: onsubmited,
      ));
    }

    List<Widget> _buildInitialData(DocumentSnapshot document) {
      List<Widget> returnData = new List<Widget>();

      returnData.add(
        const SizedBox(height: 24.0),
      );
      returnData.add(_buildTextBox('ID', '', idController, null, false));
      returnData.add(
        const SizedBox(height: 24.0),
      );
      returnData.add(_buildTextBox(
        'Type',
        '',
        typeController,
      ));
      returnData.add(
        const SizedBox(height: 24.0),
      );
      returnData.add(_buildTextBox(
        'Label',
        'node label...',
        labelController,
      ));
      returnData.add(
        const SizedBox(height: 24.0),
      );
      returnData.add(_buildTextBox(
        'Description',
        'description/location...',
        descrController,
      ));
      returnData.add(
        const SizedBox(height: 24.0),
      );

      return returnData;
    }

    // Widget _buildMetricList(DocumentSnapshot document) {
    //   return new StreamBuilder<QuerySnapshot>(
    //       stream: Firestore.instance
    //           .collection('sensors')
    //           .document(document.documentID)
    //           .collection('metrics')
    //           .snapshots(),
    //       //initialData: _buildInitialData(document),
    //       builder:
    //           (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //         // if (snapshot.connectionState == ConnectionState.done)
    //         //   refreshList=false;
    //         if (!snapshot.hasData)
    //           return new Center(
    //               child: new CircularProgressIndicator(
    //             value: null,
    //             valueColor: AlwaysStoppedAnimation<Color>(
    //                 Theme.of(context).primaryColor),
    //           ));
    //         // if(refreshList) this._items =
    //         //     snapshot.data.documents.map((DocumentSnapshot document) {
    //         //   return  new MyItem(headerWidget: new Metric(document));
    //         // new Metric(document);
    //         // }).toList();
    //         // refreshList=true;
    //         return new Flex(direction: Axis.vertical, children: [
    //           new ExpansionPanelList(
    //             expansionCallback: (int index, bool isExpanded) {
    //               var y = context.ancestorWidgetOfExactType(ExpansionPanelList);
                  
    //               setState(() {
    //                 // refreshList=false;
        
    //                 var x =
    //                     context.ancestorWidgetOfExactType(ExpansionPanelList);
    //                 // _items[index].isExpanded = !_items[index].isExpanded;
    //               });
    //             },
    //             children:
    //                 snapshot.data.documents.map((DocumentSnapshot document) {
    //               return new MyItem(headerWidget: new Metric(document));
    //               // new Metric(document);
    //             }).map((MyItem item) {
    //               return new ExpansionPanel(
    //                   headerBuilder: (BuildContext context, bool isExpanded) {
    //                     return item.headerWidget;
    //                   },
    //                   isExpanded: item.isExpanded,
    //                   body: new Container(
    //                     child: new Text(
    //                         item.headerWidget.documentSnapshoot.documentID),
    //                   ));
    //               // new Metric(document);
    //             }).toList(),
    //           ),
    //         ]
    //             //     snapshot.data.documents.map((DocumentSnapshot document) {
    //             //   return new Metric(document);
    //             // }).toList(),
    //             );
    //       });
    // }

    Container _buildDetails(DocumentSnapshot document) {
      var childs = _buildInitialData(document);
      childs.add(new Container(
          // padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          // decoration: new BoxDecoration(
          //   borderRadius: new BorderRadius.all(Radius.circular(4.0)),
          //   border: Border.all(width: 1.0, color: Theme.of(context).hintColor),
          // ),
          child: new Column(children: [
            new Metrics(document),
            // _buildMetricList(document),
            // const SizedBox(height: 24.0)
          ])));
      childs.add(const SizedBox(height: 24.0));

      return new Container(
        padding: paddings,
        child: new ListView(
          children: childs,
        ),
      );
    }

    var theme = Theme.of(context);
    var titleTextStyle = new TextStyle(
        fontSize: theme.textTheme.title.fontSize, color: theme.primaryColor);
    return new StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection('sensors')
          .document(document.documentID)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData)
          return new Center(
              child: new CircularProgressIndicator(
            value: null,
            valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
          ));
        var title = document.documentID;

        return Scaffold(
          appBar: new AppBar(
            title: new Text(
              'Sensor $title',
              style: titleTextStyle,
            ),
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0.0,
            iconTheme: IconThemeData(color: theme.primaryColor),
          ),
          body: _buildDetails(snapshot.data),
          resizeToAvoidBottomPadding: false,
          floatingActionButton: showSave
              ? new FloatingActionButton(
                  child: const Icon(Icons.save),
                  onPressed: () {
                    Firestore.instance.runTransaction((transaction) async {
                      DocumentSnapshot freshSnap =
                          await transaction.get(document.reference);
                      if (freshSnap.data['descr'].toString() !=
                          descrController.text)
                        await transaction.update(freshSnap.reference,
                            {'descr': descrController.text});
                      if (freshSnap.data['label'].toString() !=
                          labelController.text)
                        await transaction.update(freshSnap.reference,
                            {'label': labelController.text});
                      if (freshSnap.data['type'].toString() !=
                          typeController.text)
                        await transaction.update(
                            freshSnap.reference, {'type': typeController.text});
                      showSave = false;
                    });
                    Navigator.pop(context);
                  },
                )
              : null,
        );
      },
    );
  }
}


