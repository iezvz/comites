import 'package:comites/modelos/persona.dart';
import 'package:flutter/material.dart';
import 'package:comites/bd/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class EditarPersona extends StatefulWidget {
  const EditarPersona({super.key});

  @override
  State<EditarPersona> createState() => _EditarPersonaState();
}

class _EditarPersonaState extends State<EditarPersona> {
  static const EDICION = 1;
  static const INSERCION = 2;

  TextEditingController nombreController = TextEditingController();
  TextEditingController edadController = TextEditingController();
  TextEditingController estadoNacimientoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textoWidget = "Añadir Persona";
    int operacion = INSERCION;
    Persona? persona;
    if (ModalRoute.of(context)?.settings.arguments != null) {
      operacion = EDICION;
      persona = ModalRoute.of(context)?.settings.arguments as Persona;
      nombreController.text = persona.nombre;
      estadoNacimientoController.text = persona.estadoNacimiento;
      edadController.text = persona.edad.toString();
      textoWidget = "Editar Persona";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(textoWidget),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
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
                    decoration:
                        const InputDecoration(labelText: "Edad"),
                    keyboardType: TextInputType.number,
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
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                  child: ElevatedButton(
                      child: Text(textoWidget),
                      onPressed: () {
                        if (operacion == EDICION) {
                          _actualizarPersona(persona!);
                        } else {
                          _insertarPersona();
                        }
                        Navigator.pop(context);
                      })))
        ],
      ),
    );
  }

  _insertarPersona() async {
    final persona = Persona(
        id: M.ObjectId(),
        nombre: nombreController.text,
        estadoNacimiento: estadoNacimientoController.text,
        edad: int.parse(edadController.text));
    await MongoDB.insertar(persona);
  }

  _actualizarPersona(Persona persona) async {
    final p = Persona(
        id: persona.id,
        nombre: nombreController.text,
        estadoNacimiento: estadoNacimientoController.text,
        edad: int.parse(edadController.text));
    await MongoDB.actualizar(p);
  }

  @override
  void dispose() {
    super.dispose();
    nombreController.dispose();
    estadoNacimientoController.dispose();
    edadController.dispose();
  }
}
