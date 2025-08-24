import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<double> _scores = List.filled(12, 0.0);
  final int userId = 1; // Substitua pelo ID do usuário logado

  Future<void> _submitWheel() async {
    final url = 'https://[SEU_URL_DO_RENDER_AQUI].onrender.com/submit_wheel';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'user_id': userId,
        'carreira': _scores[0],
        'financas': _scores[1],
        'saude': _scores[2],
        'familia': _scores[3],
        'amor': _scores[4],
        'lazer': _scores[5],
        'espiritual': _scores[6],
        'amigos': _scores[7],
        'intelectual': _scores[8],
        'emocional': _scores[9],
        'profissional': _scores[10],
        'proposito': _scores[11],
      }),
    );

    final responseData = json.decode(response.body);
    if (response.statusCode == 201) {
      _showConfirmationDialog(responseData['message']);
    } else {
      _showErrorDialog(responseData['message']);
    }
  }

  void _showConfirmationDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Sucesso'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Erro'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('Bem-vindo ao Oasis!'),
            Expanded(
              child: ListView.builder(
                itemCount: 12,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      Text('Pilar ${index + 1}'),
                      Slider(
                        value: _scores[index],
                        min: 0,
                        max: 10,
                        divisions: 10,
                        label: _scores[index].round().toString(),
                        onChanged: (value) {
                          setState(() {
                            _scores[index] = value;
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _submitWheel,
              child: Text('Salvar Minha Roda da Vida'),
            ),
          ],
        ),
      ),
    );
  }
}