import 'package:flutter/material.dart';
import 'package:veterinaria_flutter/ClientePage.dart';
import 'package:veterinaria_flutter/MascotaPage.dart';
import 'package:veterinaria_flutter/ConsultaPage.dart';
import 'package:veterinaria_flutter/LoginPage.dart'; // Importa la página de login

class VeterinariaHomePage extends StatefulWidget {
  @override
  _VeterinariaHomePageState createState() => _VeterinariaHomePageState();
}

class _VeterinariaHomePageState extends State<VeterinariaHomePage> {
  bool _loggingOut = false;

  void _logout(BuildContext context) async {
    setState(() {
      _loggingOut = true;
    });

    // Simulamos una pausa de 2 segundos antes de redirigir al usuario
    await Future.delayed(Duration(seconds: 2));

    // Aquí va la lógica para cerrar sesión (p. ej., borrar token de autenticación)
    // En este ejemplo, simplemente redirigimos a la página de inicio de sesión
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );

    setState(() {
      _loggingOut = false;
    });

    // Muestra un mensaje de que se cerró la sesión
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('𝐒𝐞𝐬𝐬𝐢𝐨𝐧 𝐅𝐢𝐧𝐢𝐬𝐡𝐞𝐝'),
        backgroundColor: Colors.lightBlue,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('𝐖𝐞𝐥𝐜𝐨𝐦𝐞 𝐭𝐨 𝐕𝐞𝐭 𝐒𝐲𝐬𝐭𝐞𝐦'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Text(
                '𝐑𝐞𝐠𝐢𝐬𝐭𝐞𝐫',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('𝐂𝐮𝐬𝐭𝐨𝐦𝐞𝐫𝐬'),
              leading: Icon(Icons.people),
              onTap: () {
                Navigator.pop(context); // Cerrar el drawer
                // Navegar a la pantalla de clientes
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientePage()),
                );
              },
            ),
            ListTile(
              title: Text('𝐏𝐞𝐭𝐬'),
              leading: Icon(Icons.pets),
              onTap: () {
                Navigator.pop(context); // Cerrar el drawer
                // Navegar a la pantalla de mascotas
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MascotaPage()),
                );
              },
            ),
            ListTile(
              title: Text('𝐂𝐨𝐧𝐬𝐮𝐥𝐭𝐬'),
              leading: Icon(Icons.local_hospital),
              onTap: () {
                Navigator.pop(context); // Cerrar el drawer
                // Navegar a la pantalla de consultas
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConsultaPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('𝐋𝐨𝐠 𝐎𝐮𝐭'),
              leading: Icon(Icons.exit_to_app),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://png.pngtree.com/thumb_back/fh260/background/20190221/ourmid/pngtree-solid-color-banner-simple-image_22934.jpg'), 
            fit: BoxFit.cover,
          ),
        ),
      ),
      floatingActionButton: _loggingOut
          ? FloatingActionButton(
              onPressed: null,
              child: CircularProgressIndicator(),
              backgroundColor: Colors.blueGrey,
            )
          : null,
    );
  }
}
