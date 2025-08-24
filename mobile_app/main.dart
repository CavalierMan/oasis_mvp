import 'package:flutter/material.dart';
import 'auth_screen.dart';
import 'dashboard_screen.dart';

void main() {
  runApp(OasisApp());
}

class OasisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oasis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthScreen(),
      routes: {
        '/dashboard': (context) => DashboardScreen(),
      },
    );
  }
}