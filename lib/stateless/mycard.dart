import 'package:flutter/material.dart';
import 'package:flutteroperacionrest/stateless/myCardFlutter.dart';

class MyCard extends StatelessWidget {
  static const String routeName = "/mycard";
  final double iconSize = 30.0;
  final TextStyle textStyle = TextStyle(color: Colors.grey, fontSize: 30.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "App Stateless Widget",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        elevation: 4,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MyCardFlutter(
              //child: Container(
              //padding: const EdgeInsets.all(20.0),
              //child: Column(
              //children: <Widget>[
              title: Text(
                "Call Police",
                style:
                    textStyle, //TextStyle(color: Colors.grey, fontSize: 30.0),
              ),
              icon: Icon(
                Icons.phone,
                color: Colors.greenAccent,
                size: iconSize,
              ),
            ),
            MyCardFlutter(
              title: Text('Archivo', style: textStyle),
              icon: Icon(
                Icons.attach_file,
                color: Colors.lightBlueAccent,
                size: iconSize,
              ),
            ),
            MyCardFlutter(
              title: Text('Descarga', style: textStyle),
              icon: Icon(
                Icons.archive,
                color: Colors.redAccent,
                size: iconSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
