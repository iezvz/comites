import 'package:mongo_dart/mongo_dart.dart';
import 'package:comites/utilidades/constantes.dart';
import 'package:comites/modelos/persona.dart';

class MongoDB {
  static var bd, coleccionPersonas;
  
  static conectar() async {
    bd = await Db.create(CONEXION);
    await bd.open();
    coleccionPersonas = bd.collection(COLECCION);
  }

  static Future<List<Map<String, dynamic>>> getPersonas() async {
    try {
      final personas = coleccionPersonas.find().toList();
      return personas;
    } catch (e) {
      print(e);
      
      return Future.value();
    }
  }

  static insertar(Persona persona) async {
    await coleccionPersonas.insertAll([persona.toMap()]);
  }

  static actualizar(Persona persona) async {
    var p = await coleccionPersonas.findOne({"_id": persona.id});
    p["nombre"] = persona.nombre;
    p["edad"] = persona.edad;
    p["estadoNacimiento"] = persona.estadoNacimiento;
    await coleccionPersonas.save(p);
  }

  static eliminar(Persona persona) async {
      await coleccionPersonas.remove(where.id(persona.id));
  }
}
