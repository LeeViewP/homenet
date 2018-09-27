import 'package:flutter/material.dart';
import 'package:homenet/services/motesService.dart';
import './metricItem.dart';
import '../services/sensorsService.dart';
import '../model/metricModel.dart';
import '../services/metricsService.dart';
import '../model/sensorModel.dart';

class SensorView extends StatefulWidget {
  final SensorModel sensor;
  SensorView(this.sensor);
  static String get routeName => '/sensorView';

  @override
  SensorViewState createState() => new SensorViewState();
}

class SensorViewState extends State<SensorView> {
  // TextEditingController idController;
  TextEditingController labelController;
  TextEditingController descrController;
  TextEditingController typeController;
  bool showSave;
  bool canRefreshMetrics;
  MetricsService service = new MetricsService();
  SensorService sService = new SensorService();
  List<MetricModel> metrics;

  List<MetricItem> metricItems;

  List<Mote> motes;
  MotesService _motesService = new  MotesService();
  // bool isLoading;
  @override
  void initState() {
    super.initState();
    canRefreshMetrics=true;
    metricItems = new List<MetricItem>();
    service.addChangesListener(widget.sensor.id, (snapshot) {
      updateMetrics();
    });

    _motesService.addChangesListener( (snapshot) {
      updateMotes();
    });
    showSave = false;
    // idController = new TextEditingController(text: widget.sensor.id);
    labelController = new TextEditingController(text: widget.sensor.label);
    labelController.addListener(_somethingChanged);

    descrController = new TextEditingController(text: widget.sensor.descr);
    descrController.addListener(_somethingChanged);

    typeController = new TextEditingController(text: widget.sensor.type);
    typeController.addListener(_somethingChanged);
  }

void updateMotes(){
  _motesService.getAll().then((motes)=> setState(()=>this.motes=motes));
}
  void updateMetrics() {
    service.getMetrics(widget.sensor.id).then((metrics) {
      setState(() {
        this.metrics = metrics;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    labelController.removeListener(_somethingChanged);
    labelController.dispose();
    // idController.dispose();
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

  Widget _buildAlert(BuildContext context) {
    return new AlertDialog(
        title: const Text('Remove this metric?'),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text(' Stored metric data will be kept (if any).'),
              new Text(
                  'Further data from this node-metric will make it appear again.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
              child: const Text('DISAGREE'),
              onPressed: () {
                Navigator.pop(context, DialogOptions.DISAGREE);
              }),
          FlatButton(
              child: const Text('AGREE'),
              onPressed: () {
                Navigator.pop(context, DialogOptions.AGREE);
              })
        ]);
  }

  @override
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

    List<Widget> _buildInitialData() {
      List<Widget> returnData = new List<Widget>();

      // returnData.add(
      //   const SizedBox(height: 24.0),
      // );
      // returnData.add(_buildTextBox('ID', '', idController, null, false));


      // InputDecorator(
      //           decoration: const InputDecoration(
      //             labelText: 'Activity',
      //             hintText: 'Choose an activity',
      //             contentPadding: EdgeInsets.zero,
      //           ),
      //           isEmpty: _activity == null,
      //           child: DropdownButton<String>(
      //             value: _activity,
      //             onChanged: (String newValue) {
      //               setState(() {
      //                 _activity = newValue;
      //               });
      //             },
      //             items: _allActivities.map((String value) {
      //               return DropdownMenuItem<String>(
      //                 value: value,
      //                 child: Text(value),
      //               );
      //             }).toList(),
      //           ),
      //         ),

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

    Container _buildDetails() {
      var childs = _buildInitialData();
      if(canRefreshMetrics)
        metricItems = metrics.map((MetricModel model) {
        return new MetricItem<String>(
          graph: model.graph,
          label: model.label,
          hint: 'Change metric name',
          pin: model.pin,
          unit: model.unit,
          updated: model.updated,
          value: model.value,
          valueForEdit: model.label,
          valueToString: (String value) => value,
          pinOnPressed: () {
            setState(() =>
                service.update(widget.sensor.id, model.id, 'pin', !model.pin));
          },
          graphOnPressed: () {
            setState(() => service.update(
                widget.sensor.id, model.id, 'graph', !model.graph));
          },
          builder: (MetricItem<String> item) {
            void close() {
              setState(() {
                canRefreshMetrics = true;
                item.isExpanded = false;
              });
            }

            return Form(
              child: Builder(
                builder: (BuildContext context) {
                  return CollapsibleBody(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    onSave: () {
                      Form.of(context).save();
                      close();
                    },
                    onCancel: () {
                      Form.of(context).reset();
                      close();
                    },
                    onDelete: () async {
                      // Future<Null> _askedToLead() async {
                      switch (await showDialog<DialogOptions>(
                          context: context, builder: _buildAlert)) {
                        case DialogOptions.AGREE:
                          service.delete(widget.sensor.id, model.id);
                          Form.of(context).reset();
                          close();
                          break;
                        case DialogOptions.DISAGREE:
                          break;
                      }
                      // };
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: TextFormField(
                        controller: item.textController,
                        decoration: InputDecoration(
                            border: new OutlineInputBorder(),
                            hintText: item.hint,
                            labelText: 'Metric label' //item.label,
                            ),
                        // autofocus: true,
                        onSaved: (String value) {
                          service.update(
                              widget.sensor.id, model.id, 'label', value);
                          // item.valueForEdit = value;
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      }).toList();
      
      childs.add(new Flex(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          direction: Axis.vertical,
          children: [
            new ExpansionPanelList(
                //  animationDuration: Duration(seconds: 10),
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    canRefreshMetrics = isExpanded;
                    metricItems[index].isExpanded =
                        !metricItems[index].isExpanded;
                  });
                },
                children: metricItems.map((MetricItem<dynamic> item) {
                  return ExpansionPanel(
                      isExpanded: item.isExpanded,
                      headerBuilder: item.headerBuilder,
                      body: item.build());
                }).toList()),
          ]));

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
    var title = widget.sensor.id;
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Sensor ID: $title',
          style: titleTextStyle,
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: theme.primaryColor),
        actions: <Widget>[
          PopupMenuButton<String>(
             onSelected: showMenuSelection,
                         itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                           const PopupMenuItem<String>(
                             value: 'DELETE',
                             child: ListTile(
                                 leading: Icon(Icons.delete),
                                 title: Text('Delete sensor'),
                                 )
                           ),
                         ],)
                     ],
                   ),
                   body: _buildDetails(),
                   floatingActionButton: showSave
                       ? new FloatingActionButton(
                           child: const Icon(Icons.save),
                           onPressed: () {
                             if (widget.sensor.descr != descrController.text)
                               sService.update<String>(
                                   widget.sensor.id, 'descr', descrController.text);
                             if (widget.sensor.label != labelController.text)
                               sService.update<String>(
                                   widget.sensor.id, 'label', labelController.text);
                             if (widget.sensor.type != typeController.text)
                               sService.update<String>(
                                   widget.sensor.id, 'type', typeController.text);
             
                             showSave = false;
                             Navigator.pop(context);
                           },
                         )
                       : null,
                 );
               }
             
               void showMenuSelection(String value) {
                 switch(value){
                   case 'DELETE':
                    sService.delete(widget.sensor);
                    Navigator.pop(context);
                   break;
                 }
  }
}
