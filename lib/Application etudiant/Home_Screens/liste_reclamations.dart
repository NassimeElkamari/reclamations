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
      backgroundColor: Color.fromARGB(255, 235, 104, 158),
     body: Center(child: Text("liste")),
    );
  }
}