import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Mascota {
  final int id;
  final String nombre;
  final String tipo;
  final String raza;
  final int edad;
  final int clienteId;

  Mascota({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.raza,
    required this.edad,
    required this.clienteId,
  });

  factory Mascota.fromJson(Map<String, dynamic> json) {
    return Mascota(
      id: json['id'],
      nombre: json['nombre'],
      tipo: json['tipo'],
      raza: json['raza'],
      edad: json['edad'],
      clienteId: json['cliente_id'],
    );
  }
}

class MascotaPage extends StatefulWidget {
  @override
  _MascotaPageState createState() => _MascotaPageState();
}

class _MascotaPageState extends State<MascotaPage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _razaController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _clienteIdController = TextEditingController();

  List<Mascota> _mascotasList = [];

  @override
  void initState() {
    super.initState();
    _fetchMascotas();
  }

  Future<void> _fetchMascotas() async {
    String apiUrl = 'http://127.0.0.1:8000/api/pets';

    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Mascota> mascotas = data.map((json) => Mascota.fromJson(json)).toList();
        setState(() {
          _mascotasList = mascotas;
        });
      } else {
        throw Exception('Failed to load mascotas');
      }
    } catch (error) {
      throw Exception('Failed to load mascotas');
    }
  }

  Future<void> _addMascota(BuildContext context) async {
    String apiUrl = 'http://127.0.0.1:8000/api/pets/create';

    Map<String, String> data = {
      'nombre': _nombreController.text,
      'tipo': _tipoController.text,
      'raza': _razaController.text,
      'edad': _edadController.text,
      'cliente_id': _clienteIdController.text,
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
        await _fetchMascotas(); // Actualizar la lista de mascotas después de agregar una nueva
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('𝐄𝐫𝐫𝐨𝐫 𝐚𝐝𝐝𝐢𝐧𝐠 𝐩𝐞𝐭. 𝐓𝐫𝐲 𝐚𝐠𝐚𝐢𝐧.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('𝐄𝐫𝐫𝐨𝐫 𝐚𝐝𝐝𝐢𝐧𝐠 𝐩𝐞𝐭. 𝐓𝐫𝐲 𝐚𝐠𝐚𝐢𝐧.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('𝐏𝐞𝐭𝐬'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'R𝐞𝐠𝐢𝐬𝐭𝐞𝐫 𝐩𝐞𝐭:',
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
              controller: _tipoController,
              decoration: InputDecoration(
                hintText: '𝐒𝐩𝐞𝐜𝐢𝐞',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _razaController,
              decoration: InputDecoration(
                hintText: '𝐁𝐫𝐞𝐞𝐝',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _edadController,
              decoration: InputDecoration(
                hintText: 'A𝐠𝐞',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _clienteIdController,
              decoration: InputDecoration(
                hintText: '𝐂𝐮𝐬𝐭𝐨𝐦𝐞𝐫_𝐈𝐝',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_nombreController.text.isEmpty ||
                    _tipoController.text.isEmpty ||
                    _razaController.text.isEmpty ||
                    _edadController.text.isEmpty ||
                    _clienteIdController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('𝐀ll 𝐅ields 𝐀re 𝐑equired'),
                      backgroundColor: Colors.yellow,
                    ),
                  );
                  return;
                }

                await _addMascota(context);

                _nombreController.clear();
                _tipoController.clear();
                _razaController.clear();
                _edadController.clear();
                _clienteIdController.clear();
              },
              child: Text('𝐀𝐝𝐝'),
            ),
            SizedBox(height: 16),
            Text(
              '𝐂𝐮𝐬𝐭𝐨𝐦𝐞𝐫 𝐋𝐢𝐬𝐭:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: _mascotasList.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _mascotasList.length,
                      itemBuilder: (context, index) {
                        Mascota mascota = _mascotasList[index];
                        return Card(
                          margin: EdgeInsets.all(8.0),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nombre: ${mascota.nombre}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Tipo: ${mascota.tipo}'),
                                Text('Raza: ${mascota.raza}'),
                                Text('Edad: ${mascota.edad.toString()} años'),
                                Text('Cliente Id: ${mascota.clienteId.toString()}'),
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
