import 'package:comites/modelos/persona.dart';
import 'package:flutter/material.dart';

class FichaPersona extends StatelessWidget {
  const FichaPersona(
      {super.key,
      required this.onTapDelete,
      required this.onTapEdit,
      required this.persona, required itemCount});
  final Persona persona;
  final VoidCallback onTapEdit, onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: Colors.cyan,
      child: ListTile(
          leading: Text(
            persona.nombre,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          title: Text(persona.estadoNacimiento),
          subtitle: Text("${persona.edad}"),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: onTapEdit,
                child: const Icon(Icons.edit),
              ),
              GestureDetector(
                onTap: onTapDelete,
                child: const Icon(Icons.delete),
              )
            ],),
          ),
    );
  }
}
