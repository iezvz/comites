// Import necessary libraries

import 'package:comites/bd/mongodb.dart';
import 'package:comites/ui/portada.dart';
import 'package:flutter/material.dart';
void main() async {
  // Garantiza que Flutter esté inicializado antes de usar widgets
  WidgetsFlutterBinding.ensureInitialized();

  // Establece la conexión con la base de datos MongoDB Atlas antes de iniciar la aplicación
  await MongoDB.conectar();

  // Ejecuta la aplicación con la clase MyApp como raíz
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Este widget es el widget raíz de la aplicación
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Oculta el banner de modo debug
      debugShowCheckedModeBanner: false,
      // Título de la aplicación
      title: 'Comites',
      // Tema de la aplicación (colores primarios)
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      // Widget inicial de la aplicación (pantalla de portada)
      home:  const Portada(),
    );
  }
}
