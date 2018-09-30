import 'package:flutter/material.dart';
import 'package:homenet/views/customAppBar.dart';

class LoadingView extends StatelessWidget {
  final String title;
  LoadingView({this.title});
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var titleTextStyle = new TextStyle(
        fontSize: theme.textTheme.title.fontSize, color: theme.primaryColor);

    return new Scaffold(
      appBar: new HomNetAppBar(
        title: new Text(
            title??'',
            style: titleTextStyle,
          ),
        backgroundColor: theme.scaffoldBackgroundColor,
          iconTheme: IconThemeData(color: theme.primaryColor),
      ),
      body: Container(
        child: new LinearProgressIndicator(
          value: null,
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
