import 'package:mongo_dart/mongo_dart.dart';

class Persona {
  // Identificador único de la persona (ObjectId de MongoDB)
  final ObjectId id;

  // Nombre de la persona
  final String nombre;

  // Edad de la persona
  final int edad;

  // Estado de nacimiento de la persona (Aguascalientes, Jalisco, Etc.)
  final String estadoNacimiento;

  // Constructor de la clase Persona
  const Persona({
    required this.id,
    required this.nombre,
    required this.edad,
    required this.estadoNacimiento,
  });

  // Convierte la persona a un mapa JSON
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'nombre': nombre,
      'edad': edad,
      'estadoNacimiento': estadoNacimiento,
    };
  }

  // Crea una instancia de Persona a partir de un mapa JSON
  factory Persona.fromMap(Map<String, dynamic> map) {
    return Persona(
      nombre: map['nombre'],
      id: map['_id'],
      edad: map['edad'],
      estadoNacimiento: map['estadoNacimiento'],
    );
  }
}
