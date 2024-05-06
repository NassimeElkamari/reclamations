import 'package:flutter/material.dart';

class Liste_des_reclamations extends StatefulWidget {
  const Liste_des_reclamations({super.key});

  @override
  State<Liste_des_reclamations> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Liste_des_reclamations> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "   Réclamations",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 39, 45, 55),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.white,
            onPressed: () {
              // Ajoutez ici la logique de déconnexion
            },
          ),
        ], // Couleur de la barre d'applications
      ),
      backgroundColor: Color.fromARGB(255, 235, 104, 158),
     body: Center(child: Text("liste")),
    );
  }
}