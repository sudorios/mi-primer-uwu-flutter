import 'package:appepexamenpo/tabs/bike.dart';
import 'package:appepexamenpo/tabs/car.dart';
import 'package:appepexamenpo/tabs/transit.dart';
import 'package:flutter/material.dart';

class Pregunta3AP extends StatefulWidget {
  static const String routeName = "/pregunta3ap";

  const Pregunta3AP({super.key});

  @override
  State<Pregunta3AP> createState() => _Pregunta3APState();
}

class _Pregunta3APState extends State<Pregunta3AP> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pregunta 3 - TabBar'),
        backgroundColor: Colors.deepPurple,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_transit)),
            Tab(icon: Icon(Icons.directions_bike)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Car(),    
          Transit(),  
          Bike(),     
        ],
      ),
    );
  }
}
