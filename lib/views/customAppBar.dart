import 'package:flutter/material.dart';

class HomNetAppBar extends AppBar {
  HomNetAppBar(
      {Key key,
      Widget title,
      Color backgroundColor,
      List<Widget> actions,
      IconThemeData iconTheme,
      PreferredSizeWidget bottom})
      : super(
          backgroundColor: backgroundColor,
          title: title,
          actions: actions,
          bottom: bottom,
          elevation: 0.0,
          iconTheme: iconTheme,
        );
}
