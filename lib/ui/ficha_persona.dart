// Import necessary libraries
import 'package:comites/modelos/persona.dart';
import 'package:flutter/material.dart';

class FichaPersona extends StatelessWidget {

  const FichaPersona({required this.persona, required this.onTapDelete, required this.onTapEdit});
  final Persona persona;
  final VoidCallback onTapEdit, onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      color: Colors.blue,
      child: ListTile(
        leading: Text(persona.nombre),
        title:Text('${persona.edad}', style: Theme.of(context).textTheme.bodyMedium) ,
        subtitle: Text(persona.estadoNacimiento),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: onTapEdit,
              child:const Icon(Icons.edit)
            ),
            GestureDetector(
              onTap: onTapDelete,
              child:const Icon(Icons.delete),
            )
          ],
        ),
      )
    );

  }

}