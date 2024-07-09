// Import necessary libraries
import 'package:comites/ui/edita_persona.dart';
import 'package:flutter/material.dart';
import 'package:comites/bd/mongodb.dart';
import 'package:comites/modelos/persona.dart';
import 'package:comites/ui/ficha_persona.dart';

class Portada extends StatefulWidget {
  @override
  _PortadaState createState() => _PortadaState();
}

class _PortadaState extends State<Portada> {

  @override
  void initState() {
    super.initState();
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MongoDB.getPersonas(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
            child: const LinearProgressIndicator(
              backgroundColor: Colors.black,
          )
          );
        } else if (snapshot.hasError) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Text("Lo sentimos, hubo un error. Inténtelo de nuevo.",
                style: Theme.of(context).textTheme.headlineMedium,)
            )
          );
        }
        else {
          return Scaffold(
            appBar: AppBar(
            title:const Text("Lista de Personas")
          ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FichaPersona(
            persona: Persona.fromMap(snapshot.data[index]),
            onTapDelete: () async {
              _eliminarPersona(Persona.fromMap(snapshot.data[index]));
            },
            onTapEdit: () async {
              Navigator.push(context,
              MaterialPageRoute(
              builder: (BuildContext context) {
                return EditarPersona();
              },
              settings: RouteSettings(
                arguments: Persona.fromMap(snapshot.data[index]),
        )
              )).then((value)=>setState(() {}));
            }, 
        )
            );
        },
        itemCount: snapshot.data.length,
        ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                  return EditarPersona();
                })).then((value) => setState(() {}));
              },
              child: const Icon(Icons.add),
            ),
          );
        }
      },

    );
  }

  _eliminarPersona(Persona persona) async {
    await MongoDB.eliminar(persona);
    setState(() {    });
  }
}