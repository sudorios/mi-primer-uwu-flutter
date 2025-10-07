import 'package:flutter/material.dart';

class Home1 extends StatelessWidget {
  static const routeName = '/home';
  const Home1({super.key});
  @override
  Widget build(BuildContext context) {
    Drawer getDrawer(BuildContext context) {
      var header = const DrawerHeader(child: Text("Ajustes"));
      var info = AboutListTile(
        child: Text('Informacion APP'),
        applicationIcon: Icon(Icons.favorite),
        applicationVersion: 'v1.0.0',
        icon: Icon(Icons.info),
      );
      ListTile getItem(Icon icon, String description, String route) {
        return ListTile(
          leading: icon,
          title: Text(description),
          onTap: () {
            Navigator.pushNamed(context, route);
          },
        );
      }

      ListView getList() {
        return ListView(
          children: <Widget>[
            header,
            getItem(const Icon(Icons.home), 'Página Principal', '/'),
            getItem(const Icon(Icons.settings), 'Pregunta1', '/pregunta1ap'),
            getItem(const Icon(Icons.settings), 'Pregunta2', '/pregunta2ap'),
            getItem(
              const Icon(Icons.battery_charging_full),
              'Pregunta3',
              '/pregunta3ap',
            ),
            getItem(Icon(Icons.tab), 'Pregunta4', '/pregunta4ap'),
            getItem(Icon(Icons.card_giftcard), 'Pregunta6', '/pregunta5ap'),
            getItem(Icon(Icons.card_giftcard), 'Pregunta5', '/pregunta6ap'),
            info,
          ],
        );
      }

      return Drawer(child: getList());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Screen',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue,
        shadowColor: Colors.grey,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: getDrawer(context),
    );
  }
}
