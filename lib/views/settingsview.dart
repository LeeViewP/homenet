import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homenet/businesslogic/sensorsBusinessLogic.dart';
import 'package:homenet/businesslogic/sensorBusinessLogic.dart';
import 'package:homenet/views/customAppBar.dart';

import '../services/settingsService.dart';
import './loadingView.dart';

// import 'package:ehabitat/views/drawerhomenet.dart';
class SettingsView extends StatefulWidget {
  static String routeName = '/settingsView';
  @override
  SettingsViewState createState() => new SettingsViewState();
}

class SettingsViewState extends State<SettingsView> {
  SensorsBusinessLogic allsensors;
  List<SensorBusinessLogic> sensors;

  SettingsService _service = new SettingsService();
  List<GroupSettingsModel> _settings;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    allsensors = new SensorsBusinessLogic();
    sensors = allsensors.sensors;

    this._service.addChangesListener((snapshot) {
      this._service.getAll().then((settings) {
        setState(() {
          this._settings = settings;
          this._isLoading = false;
        });
      });
    });
  }

  Widget build(BuildContext context) {
    if (this._isLoading) return new LoadingView(title: "Settings");
    var theme = Theme.of(context);
    var titleTextStyle = new TextStyle(
        fontSize: theme.textTheme.title.fontSize, color: theme.primaryColor);

    Widget _buildSettingsItem(dynamic settingItem) {
      if (settingItem is TextTypeSetting)
        return new TextField(
          decoration: new InputDecoration(
            border: new OutlineInputBorder(),
            labelText: settingItem.id,
            enabled: settingItem.editable,
          ),
          controller: new TextEditingController(text: settingItem.value),
        );

      if (settingItem is PasswordTypeSetting)
        return new TextField(
          decoration: new InputDecoration(
            border: new OutlineInputBorder(),
            labelText: settingItem.id,
            enabled: settingItem.editable,
          ),
          obscureText: true,
          controller: new TextEditingController(text: settingItem.value),
        );
      if (settingItem is EmailTypeSetting)
        return new TextField(
          decoration: new InputDecoration(
            border: new OutlineInputBorder(),
            labelText: settingItem.id,
            enabled: settingItem.editable,
          ),
          keyboardType: TextInputType.emailAddress,
          controller: new TextEditingController(text: settingItem.value),
        );
      if (settingItem is CheckBoxTypeSetting)
        return new InputDecorator(
          decoration: new InputDecoration(
          border: new OutlineInputBorder(),
          labelText: '${settingItem.id}',
          // hintText: 'Choose a type for this sensor',
          contentPadding:
              EdgeInsets.only(left: 12.0, right: 12.0, top: 6.0, bottom: 6.0),
        ),
        child: new Container( 
          // margin: const EdgeInsets.only(top: 48.0), 
          margin: const EdgeInsets.only(top: 16.0), 
         child: new Switch( activeColor: theme.primaryColor , value: settingItem.value, onChanged: (bool value){ setState(() {
                    settingItem.value = value;
                  });},),
        ));
      if (settingItem is NumberTypeSetting)
        return new TextField(
          decoration: new InputDecoration(
            border: new OutlineInputBorder(),
            labelText: settingItem.id,
            enabled: settingItem.editable,
          ),
          keyboardType: TextInputType.number,
          controller:
              new TextEditingController(text: settingItem.value.toString()),
          // inputFormatters: <TextInputFormatter> [
          //           WhitelistingTextInputFormatter.digitsOnly,]
        );
      
      if (settingItem is RangeTypeSetting)
        return 
        new InputDecorator(
        decoration: new InputDecoration(
          border: new OutlineInputBorder(),
          labelText: '${settingItem.id}: ${settingItem.value.toStringAsPrecision(3)}',
          // hintText: 'Choose a type for this sensor',
          contentPadding:
              EdgeInsets.only(left: 12.0, right: 12.0, top: 6.0, bottom: 6.0),
        ),
        child:
        new Container( 
          // margin: const EdgeInsets.only(top: 48.0), 
          margin: const EdgeInsets.only(top: 16.0), 
         child: Slider(
          min: settingItem.min.toDouble(),
          max: settingItem.max.toDouble(),
          // divisions: (settingItem.max*100-settingItem.min*100).toInt(),
          value: settingItem.value.toDouble(),
          label: settingItem.value.toStringAsPrecision(3),
          onChanged: (double value){setState(() {
                      settingItem.value=value;
                    });},
          // )]
        )));
    }

    return Scaffold(
        appBar: new HomNetAppBar(
          title: new Text(
            'Settings',
            style: titleTextStyle,
          ),
          backgroundColor: theme.scaffoldBackgroundColor,
          iconTheme: IconThemeData(color: theme.primaryColor),
        ),
        body: new Container(
          margin: const EdgeInsets.all(8.0),
          child: new ListView(children: [
            new ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  this._settings[index].isExpanded =
                      !this._settings[index].isExpanded;
                });
              },
              children: this._settings.map((GroupSettingsModel group) {
                return new ExpansionPanel(
                    isExpanded: group.isExpanded,
                    headerBuilder: (BuildContext context, bool isExpanded) =>
                        new Container(
                            margin: const EdgeInsets.all(8.0),
                            child: new Text(
                              group.id,
                              style: titleTextStyle,
                            )),
                    body: new Column(
                      children: group.children
                          .map((item) => new Container(
                              margin: const EdgeInsets.all(8.0),
                              child: _buildSettingsItem(item)))
                          .toList(),
                    ));
              }).toList(),
            ),
          ]),
        ));
  }
}
