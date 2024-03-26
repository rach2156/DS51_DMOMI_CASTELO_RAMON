import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Cliente {
  final int id;
  final String nombre;
  final String telefono;
  final String email;
  final String direccion;

  Cliente({
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.email,
    required this.direccion,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      nombre: json['nombre'],
      telefono: json['telefono'],
      email: json['email'],
      direccion: json['direccion'],
    );
  }
}

class ClientePage extends StatefulWidget {
  @override
  _ClientePageState createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();

  List<Cliente> _clientesList = [];

  Future<void> _getClientes() async {
    String apiUrl = 'http://127.0.0.1:8000/api/customers';
    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        setState(() {
          _clientesList = data.map((e) => Cliente.fromJson(e)).toList();
        });
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _clientes(BuildContext context) async {
    if (_nombreController.text.isEmpty ||
        _telefonoController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _direccionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('𝐀ll 𝐅ields 𝐀re 𝐑equired'),
          backgroundColor: Colors.yellow,
        ),
      );
      return;
    }

    String apiUrl = 'http://127.0.0.1:8000/api/customers/create';

    Map<String, String> data = {
      'nombre': _nombreController.text,
      'telefono': _telefonoController.text,
      'email': _emailController.text,
      'direccion': _direccionController.text,
    };
    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: data,
      );

      if (response.statusCode == 200) {
        print('𝐒𝐮𝐜𝐜𝐞𝐬𝐬𝐟𝐮𝐥𝐥𝐲 𝐚𝐝𝐝𝐞𝐝');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('𝐒𝐮𝐜𝐜𝐞𝐬𝐬𝐟𝐮𝐥𝐥𝐲 𝐚𝐝𝐝𝐞𝐝'),
            backgroundColor: Colors.greenAccent,
          ),
        );
        _getClientes(); // Actualizar la lista de clientes después de agregar uno nuevo
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('𝐄𝐫𝐫𝐨𝐫 𝐚𝐝𝐝𝐢𝐧𝐠 𝐜𝐮𝐬𝐭𝐨𝐦𝐞𝐫. 𝐓𝐫𝐲 𝐚𝐠𝐚𝐢𝐧.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getClientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('𝐂𝐮𝐬𝐭𝐨𝐦𝐞𝐫𝐬'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '𝐑𝐞𝐠𝐢𝐬𝐭𝐞𝐫 𝐂𝐮𝐬𝐭𝐨𝐦𝐞𝐫:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                hintText: '𝐍𝐚𝐦𝐞',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _telefonoController,
              decoration: InputDecoration(
                hintText: '𝐏𝐡𝐨𝐧𝐞',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: '𝐄-𝐦𝐚𝐢𝐥',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _direccionController,
              decoration: InputDecoration(
                hintText: '𝐀𝐝𝐝𝐫𝐞𝐬𝐬',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _clientes(context);
              },
              child: Text('𝐀𝐝𝐝'),
            ),
            SizedBox(height: 16),
            Text(
              'Lista de clientes:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: _clientesList.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _clientesList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(_clientesList[index].nombre),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Teléfono: ${_clientesList[index].telefono}'),
                                Text('Email: ${_clientesList[index].email}'),
                                Text('Dirección: ${_clientesList[index].direccion}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Gestión Veterinaria',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: ClientePage(),
  ));
}
