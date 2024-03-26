import 'package:flutter/material.dart';
import 'ClientePage.dart';
import 'MascotaPage.dart';
import 'ConsultaPage.dart';
import 'VeterinariaHomePage.dart';
import 'Onboardingscreen.dart';
import 'RegistroPage.dart';
import 'LoginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Veterinaria App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => OnboardingScreen(), // Pantalla de inicio
        '/veterinariahomepage': (context) => VeterinariaHomePage(), // Pantalla principal
        '/clientes': (context) => ClientePage(), // Vista de clientes
        '/mascotas': (context) => MascotaPage(), // Vista de mascotas
        '/consultas': (context) => ConsultaPage(), // Vista de consultas
        '/registros': (context) => RegistroPage(), // Vista de registros
        '/loginpage': (context) => LoginPage(), // Vista de login

        
        
      },
    );
  }
}
