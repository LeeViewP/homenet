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
          controller: settingItem.controller,
        );

      if (settingItem is PasswordTypeSetting)
        return new TextField(
          decoration: new InputDecoration(
            border: new OutlineInputBorder(),
            labelText: settingItem.id,
            enabled: settingItem.editable,
          ),
          obscureText: true,
          controller: settingItem.controller,
        );
      if (settingItem is EmailTypeSetting)
        return new TextField(
          decoration: new InputDecoration(
            border: new OutlineInputBorder(),
            labelText: settingItem.id,
            enabled: settingItem.editable,
          ),
          keyboardType: TextInputType.emailAddress,
          controller: settingItem.controller,
        );
      if (settingItem is CheckBoxTypeSetting)
        return new InputDecorator(
            decoration: new InputDecoration(
              border: new OutlineInputBorder(),
              labelText: '${settingItem.id}',
              // hintText: 'Choose a type for this sensor',
              contentPadding: EdgeInsets.only(
                  left: 12.0, right: 12.0, top: 6.0, bottom: 6.0),
            ),
            child: new Container(
                // margin: const EdgeInsets.only(top: 48.0),
                // margin: const EdgeInsets.only(left: 50.0),
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                  new Switch(
                    activeColor: theme.primaryColor,
                    value: settingItem.value,
                    onChanged: (bool value) {
                      setState(() {
                        settingItem.value = value;
                      });
                    },
                  ),
                ])));
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
         return new TextField(
          decoration: new InputDecoration(
            border: new OutlineInputBorder(),
            labelText: settingItem.id,
            enabled: settingItem.editable,
          ),
          keyboardType: TextInputType.number,
          controller:
              new TextEditingController(text: settingItem.value.toStringAsPrecision(3)),
          // inputFormatters: <TextInputFormatter> [
          //           WhitelistingTextInputFormatter.digitsOnly,]
        );
    }

    Widget _buildSettingsListItem(String groupId, dynamic item) {
      ListTile listTile;
      if (item is CheckBoxTypeSetting)
        listTile = new ListTile(
            title: new Text(item.id),
            subtitle: new Text(item.description),
            trailing: new Switch(
              activeColor: theme.primaryColor,
              value: item.value,
              onChanged: (bool value) {
                // setState(() {
                  _service.update<bool>(groupId, item.id, 'value', value);
                  // item.value = value;
                // });
              },
            ));
      else if (item is NumberTypeSetting || item is RangeTypeSetting)
        listTile = new ListTile(
          title: new Text(item.id),
          subtitle: new Text(item.description),
          trailing: new Text(item.value.toString()),
          onTap: () async {
            switch (await showDialog<DialogOptions>(
                context: context,
                builder: (BuildContext context) => new AlertDialog(
                      title: new Text(item.id),
                      content: _buildSettingsItem(item),
                      actions: <Widget>[
                        FlatButton(
                            child: const Text('CANCEL'),
                            onPressed: () {
                              Navigator.pop(context, DialogOptions.DISAGREE);
                            }),
                        FlatButton(
                            child: Text('SAVE',
                                style: theme.textTheme.button
                                    .copyWith(color: theme.primaryColor)),
                            onPressed: () {
                              Navigator.pop(context, DialogOptions.AGREE);
                            })
                      ],
                    ))) {
              case DialogOptions.AGREE:
                  _service.update<num>(groupId, item.id,'value', item.value);

                // service.delete(widget.sensor.id, model.id);
                // Form.of(context).reset();
                // close();
                break;
              case DialogOptions.DISAGREE:
                break;
            }
          },
        );
      else
        listTile = new ListTile(
          // isThreeLine: true,
          title: new Text(item.id),

          subtitle: new Text(item.description),
          // trailing: new Text(item.value.toString()),
          onTap: () async {
            // Future<Null> _askedToLead() async {
            switch (await showDialog<DialogOptions>(
                context: context,
                builder: (BuildContext context) => new AlertDialog(
                      title: new Text(item.id),
                      content: _buildSettingsItem(item),
                      actions: <Widget>[
                        FlatButton(
                            child: const Text('CANCEL'),
                            onPressed: () {
                              Navigator.pop(context, DialogOptions.DISAGREE);
                            }),
                        FlatButton(
                            child: const Text('SAVE'),
                            onPressed: () {
                              Navigator.pop(context, DialogOptions.AGREE);
                            })
                      ],
                    ))) {
              case DialogOptions.AGREE:
                String itemId = item.id;
                _service.update<String>(groupId, itemId,'value', item.controller.text);
                // service.delete(widget.sensor.id, model.id);
                // Form.of(context).reset();
                // close();
                break;
              case DialogOptions.DISAGREE:
                break;
            }
          },
        );

      return new Container(
          decoration: new BoxDecoration(
              border: new Border(
            bottom: BorderSide(color: Theme.of(context).dividerColor),
          )),
          child: listTile);
    }

    Widget _builtGroupSettings(GroupSettingsModel model) {
      var groupTextStyle = new TextStyle(
          fontSize: theme.textTheme.subhead.fontSize,
          color: theme.primaryColor);
      List<Widget> groupItems = new List<Widget>();
      groupItems.add(new Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 16.0, top: 24.0, bottom: 8.0),
          child: new Text(
            model.id,
            textAlign: TextAlign.start,
            style: groupTextStyle,
          )));
      groupItems
          .addAll(model.children.map((item) => _buildSettingsListItem(model.id,item)));
      return Column(children: groupItems.toList());
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
      body: new ListView(
          children: this._settings.map((GroupSettingsModel group) {
        return _builtGroupSettings(group);
      }).toList()),

      // new Flex(
      //     direction: Axis.vertical,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     mainAxisSize: MainAxisSize.max,
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: [
      //       new Flexible(
      //         // margin: const EdgeInsets.all(8.0),
      //         child: new ListView(children: [
      //           new ExpansionPanelList(
      //             expansionCallback: (int index, bool isExpanded) {
      //               setState(() {
      //                 this._settings[index].isExpanded =
      //                     !this._settings[index].isExpanded;
      //               });
      //             },
      //             children: this._settings.map((GroupSettingsModel group) {
      //               return new ExpansionPanel(
      //                   isExpanded: group.isExpanded,
      //                   headerBuilder:
      //                       (BuildContext context, bool isExpanded) =>
      //                           new Container(
      //                               margin: const EdgeInsets.all(8.0),
      //                               child: new Text(
      //                                 group.id,
      //                                 style: titleTextStyle,
      //                               )),
      //                   body: new Column(
      //                     children: group.children
      //                         .map((item) => new Container(
      //                             margin: const EdgeInsets.all(8.0),
      //                             child: _buildSettingsItem(item)))
      //                         .toList(),
      //                   ));
      //             }).toList(),
      //           ),
      //         ]),
      //       ),
      //     ])
    );
  }
}

enum DialogOptions { AGREE, DISAGREE }
