// Importar las bibliotecas necesarias
import 'package:comites/modelos/persona.dart';
import 'package:flutter/material.dart';
import 'package:comites/bd/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as M; // Alias para mongo_dart

class EditarPersona extends StatefulWidget {
  // Constructor para recibir argumentos iniciales (si los hay)
  const EditarPersona({super.key});

  @override
  State<EditarPersona> createState() => _EditarPersonaState();
}

class _EditarPersonaState extends State<EditarPersona> {
  // Definir constantes para operaciones de inserción y edición
  static const int EDICION = 1;
  static const int INSERCION = 2;

  // Controladores de edición de texto para la entrada del usuario
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController edadController = TextEditingController();
  final TextEditingController estadoNacimientoController =
      TextEditingController();

  // Variables para almacenar el tipo de operación y los datos de la persona (si se edita)
  int operacion = INSERCION;
  Persona? persona;

  @override
  Widget build(BuildContext context) {
    // Establecer el título en función de la operación (agregar o editar)
    String textoWidget = "Añadir Persona";
    if (ModalRoute.of(context)?.settings.arguments != null) {
      operacion = EDICION;
      persona = ModalRoute.of(context)?.settings.arguments as Persona;
      nombreController.text = persona!.nombre;
      estadoNacimientoController.text = persona!.estadoNacimiento;
      edadController.text = persona!.edad.toString();
      textoWidget = "Editar Persona";
    }

    // Construir el andamio de la aplicación
    return Scaffold(
      appBar: AppBar(
        title: Text(textoWidget),
      ),
      body: Stack(
        children: [
          // SingleChildScrollView para contenido desplazable
          SingleChildScrollView(
            child: Column(
              children: [
                // Relleno para cada campo de texto
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: nombreController,
                    decoration: const InputDecoration(labelText: "Nombre"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: edadController,
                    decoration: const InputDecoration(labelText: "Edad"),
                    keyboardType:
                        TextInputType.number, // Forzar entrada numérica
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: estadoNacimientoController,
                    decoration:
                        const InputDecoration(labelText: "Lugar de Nacimiento"),
                  ),
                ),
              ],
            ),
          ),
          // Alinear el botón en el centro inferior
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
              child: ElevatedButton(
                child: Text(textoWidget),
                onPressed: () {
                  // Llamar a la función adecuada según la operación
                  if (operacion == EDICION) {
                    _actualizarPersona(persona!);
                  } else {
                    _insertarPersona();
                  }
                  // Hacer estallar la pantalla después de la operación
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Función para insertar una nueva persona
  _insertarPersona() async {
    // Crear un nuevo objeto Persona con datos de los campos de texto
    final persona = Persona(
      id: M.ObjectId(),
      nombre: nombreController.text,
      estadoNacimiento: estadoNacimientoController.text,
      edad: int.parse(edadController.text),
    );
    // Llamar a MongoDB.insertar para insertar a la persona en la base de datos
    await MongoDB.insertar(persona);
  }

  _actualizarPersona(Persona persona) async {
  // Crear un nuevo objeto Persona con datos actualizados
  debugPrint(persona.id.toString());
  final p = Persona(
    id: persona.id,
    nombre: nombreController.text,
    estadoNacimiento: estadoNacimientoController.text,
    edad: int.parse(edadController.text),
  );

  // Establecer límites de reintento
  const int maxReintentos = 3;
  int intentos = 0;

  // Attempt to update the person in the database
  while (intentos < maxReintentos) {
    try {
      await MongoDB.actualizar(p);
      debugPrint("Persona actualizada correctamente");
      return; // Actualización exitosa
    } catch (error) {
      // Manejar la excepción
      if (error is MongoConnectionException) {
        debugPrint("Error de conexión: ${error.toString()}");

        // Reabrir la conexión
        await MongoDB.conectar();

        // Reintentar la actualización
        intentos++;
        continue;
      } else {
        // Manejar otros errores
        debugPrint("Error al actualizar persona: ${error.toString()}");
        // Handle the error appropriately (e.g., display error message)
        return; // Actualización fallida
      }
    }
  }

  // Si se alcanza el límite de reintentos, marcar la actualización como fallida
  debugPrint("Error: Se alcanzó el límite de reintentos para actualizar la persona");
  // Handle the error appropriately (e.g., display error message)
}


  // liberar recursos
  @override
  void dispose() {
    super.dispose();
    nombreController.dispose();
    estadoNacimientoController.dispose();
    edadController.dispose();
  }
}
