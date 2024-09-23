import 'package:flutter/material.dart';
import 'package:myapp/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bali Tourism',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: const LoginScreen(),
    );
  }
}
