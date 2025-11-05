import 'package:flutter/material.dart';
import 'package:flutteroperacionrest/screensdraw/battery.dart';
import 'package:flutteroperacionrest/screensdraw/settings.dart';
import 'package:flutteroperacionrest/srclistainfinita/infinita.dart';
import 'package:flutteroperacionrest/srctabs/tabs.dart';
import 'package:flutteroperacionrest/stateless/myCard.dart';
import 'home.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),

      //Mapeamos
      routes: <String, WidgetBuilder>{
        Settings.routeName: (BuildContext context) => Settings(),
        Battery.routeName: (BuildContext context) => Battery(),
        MyTabs.routeName: (BuildContext context) => MyTabs(),
        MyCard.routeName: (BuildContext context) => MyCard(),
        Infinita.routeName: (BuildContext context) => Infinita(),
      },
    ),
  );
}
