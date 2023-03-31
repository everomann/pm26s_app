import 'package:flutter/material.dart';
import 'package:pm26s_app/data/ponto_turistico_inherited.dart';
import 'package:pm26s_app/screens/initial_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const InitialScreen(),
      // PontoTuristicoInherited(child: const InitialScreen()),
    );
  }
}







