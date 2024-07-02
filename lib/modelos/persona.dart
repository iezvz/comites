import 'package:mongo_dart/mongo_dart.dart';

class Persona {
  final ObjectId id;
  final String nombre;
  final int edad;
  final String estadoNacimiento;

  const Persona({
    required this.id,
    required this.nombre,
    required this.edad,
    required this.estadoNacimiento,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'nombre': nombre,
      'edad': edad,
      'estadoNacimiento': estadoNacimiento
    };
  }

  Persona.fromMap(Map<String, dynamic> map)
      : nombre = map['nombre'],
        id = map['_id'],
        edad = map['edad'],
        estadoNacimiento = map['estadoNacimiento'];
}
