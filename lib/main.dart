import 'package:flutter/material.dart';
import 'package:comites/bd/mongodb.dart';
import 'package:comites/ui/portada.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await MongoDB.conectar();
  runApp(const MyApp());  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Comites',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const Portada(),
    );
  }
}
