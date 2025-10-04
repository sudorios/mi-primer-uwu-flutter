import 'package:flutter/material.dart';
import 'package:flutteroperacionrest/sreentabs/home.dart';
import 'package:flutteroperacionrest/sreentabs/contact.dart';
import 'package:flutteroperacionrest/sreentabs/video.dart';

class MyTabs extends StatefulWidget {
  static const String routeName = '/tabs';
  @override
  _MyTabsState createState() => _MyTabsState();
}

class _MyTabsState extends State<MyTabs> {
  @override
  Widget build(BuildContext context) {
    //return Scaffold(
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My App Tabs',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          backgroundColor: Colors.blue,
          shadowColor: Colors.grey,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.yellow,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.ondemand_video)),
              Tab(icon: Icon(Icons.contacts)),
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[Home(), Video(), Contact()]),
      ),
    );
  }
}
