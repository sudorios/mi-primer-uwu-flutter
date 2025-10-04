import 'package:flutter/material.dart';

class Home extends StatelessWidget {
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
            getItem(
              const Icon(Icons.settings),
              'Configuración',
              '/configuracion',
            ),
            getItem(const Icon(Icons.home), 'Página Principal', '/'),
            getItem(
              const Icon(Icons.battery_charging_full),
              'Batería',
              '/bateria',
            ),
            getItem(Icon(Icons.tab), 'Pestañas', '/tabs'),
            getItem(Icon(Icons.card_giftcard), 'My Card', '/mycard'),
            getItem(Icon(Icons.card_giftcard), 'Lista', '/infinita'),
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
