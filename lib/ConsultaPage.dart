import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Consulta {
  final int id;
  final String fecha;
  final String motivo;
  final String diagnostico;
  final String tratamiento;
  final int mascotaId;

  Consulta({
    required this.id,
    required this.fecha,
    required this.motivo,
    required this.diagnostico,
    required this.tratamiento,
    required this.mascotaId,
  });

  factory Consulta.fromJson(Map<String, dynamic> json) {
    return Consulta(
      id: json['id'],
      fecha: json['fecha'],
      motivo: json['motivo'],
      diagnostico: json['diagnostico'],
      tratamiento: json['tratamiento'],
      mascotaId: json['mascota_id'],
    );
  }
}

class ConsultaPage extends StatefulWidget {
  @override
  _ConsultaPageState createState() => _ConsultaPageState();
}

class _ConsultaPageState extends State<ConsultaPage> {
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _motivoController = TextEditingController();
  final TextEditingController _diagnosticoController = TextEditingController();
  final TextEditingController _tratamientoController = TextEditingController();
  final TextEditingController _mascotaIdController = TextEditingController();

  List<Consulta> _consultasList = [];

  Future<void> _getConsultas() async {
    String apiUrl = 'http://127.0.0.1:8000/api/consults';
    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        setState(() {
          _consultasList = data.map((e) => Consulta.fromJson(e)).toList();
        });
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _consultas(BuildContext context) async {
    if (_fechaController.text.isEmpty ||
        _motivoController.text.isEmpty ||
        _diagnosticoController.text.isEmpty ||
        _tratamientoController.text.isEmpty ||
        _mascotaIdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('𝐀ll 𝐅ields 𝐀re 𝐑equired'),
          backgroundColor: Colors.yellow,
        ),
      );
      return;
    }

    String apiUrl = 'http://127.0.0.1:8000/api/consults/create';

    Map<String, String> data = {
      'fecha': _fechaController.text,
      'motivo': _motivoController.text,
      'diagnostico': _diagnosticoController.text,
      'tratamiento': _tratamientoController.text,
      'mascota_id': _mascotaIdController.text,
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
        _getConsultas(); // Actualizar la lista de consultas después de agregar una nueva
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('𝐄𝐫𝐫𝐨𝐫 𝐚𝐝𝐝𝐢𝐧𝐠 𝐜𝐨𝐧𝐬𝐮𝐥𝐭. 𝐓𝐫𝐲 𝐚𝐠𝐚𝐢𝐧.'),
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
    _getConsultas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('𝐂𝐨𝐧𝐬𝐮𝐥𝐭𝐬'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://media.istockphoto.com/id/174931919/es/foto/grunge-wall.jpg?b=1&s=612x612&w=0&k=20&c=58Co2WgeKDdP-8rYtLUMfQbP9HzZ9TTiIkfmVpq5-lg='),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '𝐑𝐞𝐠𝐢𝐬𝐭𝐞𝐫 𝐜𝐨𝐧𝐬𝐮𝐥𝐭:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _fechaController,
                decoration: InputDecoration(
                  hintText: 'D𝐚𝐭𝐞',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _motivoController,
                decoration: InputDecoration(
                  hintText: '𝐑𝐞𝐚𝐬𝐨𝐧',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _diagnosticoController,
                decoration: InputDecoration(
                  hintText: '𝐃𝐢𝐚𝐠𝐧𝐨𝐬𝐭𝐢𝐜',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _tratamientoController,
                decoration: InputDecoration(
                  hintText: '𝐓𝐫𝐞𝐚𝐭𝐦𝐞𝐧𝐭',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _mascotaIdController,
                decoration: InputDecoration(
                  hintText: '𝐏𝐞𝐭_𝐈𝐝',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _consultas(context);
                },
                child: Text('𝐀𝐝𝐝'),
              ),
              SizedBox(height: 16),
              Text(
                '𝐂𝐨𝐧𝐬𝐮𝐥𝐭 𝐋𝐢𝐬𝐭:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: _consultasList.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _consultasList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text('ID: ${_consultasList[index].id}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Fecha: ${_consultasList[index].fecha}'),
                                  Text('Motivo: ${_consultasList[index].motivo}'),
                                  Text('Diagnóstico: ${_consultasList[index].diagnostico}'),
                                  Text('Tratamiento: ${_consultasList[index].tratamiento}'),
                                  Text('Mascota ID: ${_consultasList[index].mascotaId}'),
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
        )    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Gestión Veterinaria',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: ConsultaPage(),
  ));
}
