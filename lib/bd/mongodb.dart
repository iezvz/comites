// Import necessary libraries
import 'package:mongo_dart/mongo_dart.dart';
import 'package:comites/utilidades/constantes.dart';
import 'package:comites/modelos/persona.dart';

class MongoDB {
  // Variables estáticas para la conexión a la base de datos y la colección de personas
  static var bd, coleccionPersonas;

  // Función para establecer la conexión con la base de datos MongoDB Atlas
  static Future<void> conectar() async {
    // Crea una instancia de la base de datos utilizando la URL de conexión
    bd = await Db.create(CONEXION);
    // Abre la conexión con la base de datos
    await bd.open();
    // Obtiene una referencia a la colección de personas
    coleccionPersonas = bd.collection(COLECCION);
  }

  // Función para obtener una lista de todas las personas de la base de datos
  static Future<List<Map<String, dynamic>>> getPersonas() async {
    try {
      // Obtiene una lista de todos los documentos en la colección de personas
      final personas = await coleccionPersonas.find().toList();
      // Devuelve la lista de personas
      return personas;
    } catch (e) {
      // Si se produce un error, imprime el mensaje de error y devuelve una lista vacía
      print(e);
      return Future.value([]);
    }
  }

  // Función para insertar una nueva persona en la base de datos
  static Future<void> insertar(Persona persona) async {
    // Convierte la persona a un mapa JSON
    final personaMap = persona.toMap();
    // Inserta el mapa JSON en la colección de personas
    await coleccionPersonas.insertAll([personaMap]);
  }

  // Función para actualizar una persona existente en la base de datos
  static Future<void> actualizar(Persona persona) async {
    // Busca la persona en la base de datos por su ID
    final p = await coleccionPersonas.findOne({"_id": persona.id});
    // Si la persona se encuentra, actualiza sus datos
    if (p != null) {
      p["nombre"] = persona.nombre;
      p["edad"] = persona.edad;
      p["estadoNacimiento"] = persona.estadoNacimiento;
      // Guarda los cambios en la base de datos
      await coleccionPersonas.save(p);
    }
  }

  // Función para eliminar una persona de la base de datos
  static Future<void> eliminar(Persona persona) async {
    // Elimina la persona de la base de datos por su ID
    await coleccionPersonas.remove(where.id(persona.id));
  }
}
