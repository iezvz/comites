// Import necessary libraries
import 'package:comites/ui/edita_persona.dart';
import 'package:flutter/material.dart';
import 'package:comites/bd/mongodb.dart';
import 'package:comites/modelos/persona.dart';
import 'package:comites/ui/ficha_persona.dart';

class Portada extends StatefulWidget {
  const Portada({super.key});

  // Crea el estado para el StatefulWidget
  @override
  State<Portada> createState() => _PortadaState();
}

class _PortadaState extends State<Portada> {
  // Construye el widget de la interfaz
  @override
  Widget build(BuildContext context) {
    // Ejecuta un FutureBuilder para obtener la lista de personas de la base de datos
    return FutureBuilder(
      future: MongoDB
          .getPersonas(), // Obtiene la lista de personas mediante MongoDB.getPersonas()
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // Maneja diferentes estados del Future: esperando, error, datos obtenidos
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Muestra un indicador de progreso mientras se esperan los datos
          return Container(
            color: Colors.white,
            child: const LinearProgressIndicator(
              backgroundColor: Colors.black,
            ),
          );
        } else if (snapshot.hasError) {
          // Muestra un mensaje de error si ocurre algún problema al obtener los datos
          return Container(
            color: Colors.white,
            child: Center(
              child: Text(
                'Lo sentimos, hubo un error. Intentelo de nuevo.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          );
        } else {
          // Si hay datos, muestra la lista de personas
          return Scaffold(
            appBar: AppBar(
              title: const Text("Lista de Personas"),
            ),
            body: ListView.builder(
              // Construye la lista de personas
              itemBuilder: (context, index) {
                // Obtiene la persona del snapshot
                final persona = Persona.fromMap(snapshot.data[index]);
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: FichaPersona(
                    persona: Persona.fromMap(snapshot
                        .data[index]), // Pasa la persona a la FichaPersona
                    onTapDelete: () async {
                      // Función para eliminar la persona
                      await _eliminarPersona(
                          persona); // Llama a la función _eliminarPersona
                    },
                    onTapEdit: () async {
                      // Función para editar la persona
                      // Navega a la pantalla EditarPersona y pasa la persona como argumento
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const EditarPersona(),
                          settings: RouteSettings(
                            arguments: persona,
                          ),
                        ),
                      ).then((value) => setState(() {}));
                    },
                    itemCount: null,
                  ),
                );
              },
              itemCount: snapshot
                  .data.length, // Define el número de elementos en la lista
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Navega a la pantalla EditarPersona para crear una nueva persona
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const EditarPersona()),
                ).then((value) => setState(() {}));
              },
              child: const Icon(Icons.add),
            ),
          );
        }
      },
    );
  }

  // Función para eliminar una persona de la base de datos
  _eliminarPersona(Persona persona) async {
    await MongoDB.eliminar(
        persona); // Elimina la persona mediante MongoDB.eliminar()
    setState(() {}); // Actualiza el estado para reflejar los cambios
  }
}
