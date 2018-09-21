import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

typedef MetricItemBodyBuilder<T> = Widget Function(MetricItem<T> item);
typedef ValueToString<T> = String Function(T value);

enum DialogOptions{AGREE,DISAGREE}

class DualHeaderWithHint extends StatelessWidget {
  const DualHeaderWithHint(
      {this.pin,
      this.graph,
      this.label,
      this.value,
      this.unit,
      this.updated,
      this.hint,
      this.showHint,
      this.pinOnPressed,
      this.graphOnPressed});

  final bool pin;
  final VoidCallback pinOnPressed;
  final bool graph;
  final VoidCallback graphOnPressed;
  final String label;
  final String value;
  final String unit;
  final DateTime updated;

  final String hint;
  final bool showHint;
  // final String name;
  // final String value;
  // final String hint;
  // final bool showHint;

  Widget _crossFade(Widget first, Widget second, bool isExpanded) {
    return AnimatedCrossFade(
      firstChild: first,
      secondChild: second,
      firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.fastOutSlowIn,
      crossFadeState:
          isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Row(children: <Widget>[
      Expanded(
        //flex: 2,
        child: Container(
            // margin: const EdgeInsets.only(left: 24.0),
            child: _crossFade(
                new FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: new IconButton(
                      alignment: Alignment.centerLeft,
                      icon: new Icon(
                        pin ? MdiIcons.pinOutline : MdiIcons.pinOffOutline,
                        color:
                            pin ? textTheme.button.color : theme.disabledColor,
                      ),
                      onPressed: pinOnPressed),
                ),
                Container(),
                showHint)),
      ),
      Expanded(
        // flex: 2,
        child: Container(
            // margin: const EdgeInsets.only(left: 24.0),
            child: _crossFade(
                new FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: new IconButton(
                      alignment: Alignment.centerLeft,
                      icon: new Icon(
                        MdiIcons.chartLineVariant,
                        color: graph
                            ? textTheme.button.color
                            : theme.disabledColor,
                      ),
                      onPressed: graphOnPressed),
                ),
                new Container(),
                showHint)),
      ),
      Expanded(
          flex: 3,
          child: Container(
              // margin: const EdgeInsets.only(left: 24.0),
              child: _crossFade(
                  new Text(label,
                      style: textTheme.subhead
                          .copyWith(fontWeight: FontWeight.normal)),
                  new Text(hint,
                      style: textTheme.caption
                          .copyWith(fontWeight: FontWeight.normal)),
                  showHint))),
      new Expanded(
          flex: 2,
          child: new Container(
              alignment: Alignment.centerRight,
              child: new Text('$value$unit',
                  style: textTheme.subhead
                      .copyWith(fontWeight: FontWeight.w800)))),
    ]);
  }
}

class CollapsibleBody extends StatelessWidget {
  const CollapsibleBody(
      {this.margin = EdgeInsets.zero, this.child, this.onSave, this.onCancel, this.onDelete});

  final EdgeInsets margin;
  final Widget child;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Column(children: <Widget>[
      Container(
          margin: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0) -
              margin,
          child: Center(
              child: DefaultTextStyle(
                  style: textTheme.caption.copyWith(fontSize: 15.0),
                  child: child))),
      const Divider(height: 1.0),
      Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            Expanded(
              flex: 3,
              child:
                Container(
                  alignment: AlignmentDirectional.centerStart,
                    child: FlatButton(
                        onPressed: onDelete,
                        textTheme: ButtonTextTheme.primary,
                        child: const Text('DELETE'))),
            ),
            Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: FlatButton(
                    onPressed: onCancel,
                    child: const Text('CANCEL',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500)))),
            Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: FlatButton(
                    onPressed: onSave,
                    textTheme: ButtonTextTheme.accent,
                    child: const Text('SAVE')))
          ]))
    ]);
  }
}

class MetricItem<T> {
  MetricItem(
      {this.pin,
      this.graph,
      this.label,
      this.valueForEdit,
      this.unit,
      this.updated,
      this.hint,
      this.pinOnPressed,
      this.graphOnPressed,
      this.builder,
      this.value,
      this.valueToString})
      : textController =
            TextEditingController(text: valueToString(valueForEdit));

  final bool pin;
  final VoidCallback pinOnPressed;
  final bool graph;
  final VoidCallback graphOnPressed;
  final String label;
  final String value;
  final String unit;
  final DateTime updated;

  final String hint;

  final TextEditingController textController;
  final MetricItemBodyBuilder<T> builder;
  final ValueToString<T> valueToString;
  T valueForEdit;
  bool isExpanded = false;

  ExpansionPanelHeaderBuilder get headerBuilder {
    return (BuildContext context, bool isExpanded) {
      return DualHeaderWithHint(
          pin: pin,
          graph: graph,
          label: label,
          updated: updated,
          unit: unit,
          pinOnPressed: pinOnPressed,
          graphOnPressed: graphOnPressed,
          value: value,
          // value: valueToString(valueForEdit),
          hint: hint,
          showHint: isExpanded);
    };
  }

  Widget build() => builder(this);
}
