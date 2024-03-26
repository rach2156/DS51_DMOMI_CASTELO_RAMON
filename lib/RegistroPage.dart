import 'package:flutter/material.dart';
import 'ClientePage.dart';
import 'MascotaPage.dart';
import 'ConsultaPage.dart';

class RegistroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientePage()),
                );
              },
              child: Text('Ir a clientes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MascotaPage()),
                );
              },
              child: Text('Ir a mascotas'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConsultaPage()),
                );
              },
              child: Text('Ir a consultas'),
            ),
          ],
        ),
      ),
    );
  }
}
