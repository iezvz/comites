// Import necessary libraries
import 'package:comites/modelos/persona.dart';
import 'package:flutter/material.dart';

class FichaPersona extends StatelessWidget {
  // Constructor with required parameters
  const FichaPersona({
    super.key,
    required this.persona, // Person object to display
    required this.onTapEdit, // Callback function for edit button
    required this.onTapDelete, required itemCount, // Callback function for delete button
    // Removed itemCount parameter (not used in this widget)
  });

  // Receives the Persona object and callback functions
  final Persona persona;
  final VoidCallback onTapEdit;
  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    // Builds the visual representation of the person information
    return Material(
      // Adds a slight shadow effect
      elevation: 2,
      // Sets the background color
      color: Colors.cyan,
      child: ListTile(
        // Leading - Displays the person's name prominently
        leading: Text(
          persona.nombre,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        // Title - Displays the person's marital status
        title: Text(persona.estadoNacimiento),
        // Subtitle - Displays the person's age
        subtitle: Text("${persona.edad}"),
        // Trailing - Shows buttons on the right side
        trailing: Column(
          // Positions buttons vertically with equal spacing
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Edit button
            GestureDetector(
              onTap: onTapEdit, // Calls the provided callback function
              child: const Icon(Icons.edit),
            ),
            // Delete button
            GestureDetector(
              onTap: onTapDelete, // Calls the provided callback function
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
