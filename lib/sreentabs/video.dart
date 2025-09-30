import 'package:flutter/material.dart';

class Video extends StatefulWidget {
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Icon(Icons.ondemand_video, size: 170, color: Colors.green),
          Text("Segundo tabs"),
        ],
      ),
    );
  }
}
