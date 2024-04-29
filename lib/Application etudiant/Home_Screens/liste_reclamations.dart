import 'package:flutter/material.dart';
class ListeReclamations_etudiant extends StatefulWidget {
  const ListeReclamations_etudiant({super.key});

  @override
  State<ListeReclamations_etudiant> createState() => _ListeReclamations_etudiantState();
}

class _ListeReclamations_etudiantState extends State<ListeReclamations_etudiant> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromARGB(255, 168, 198, 255),
     body: Center(child: Text("liste")),
    );
  }
}