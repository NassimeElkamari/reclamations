import 'package:flutter/material.dart';
class ProfileEtudiant extends StatefulWidget {
  const ProfileEtudiant({super.key});

  @override
  State<ProfileEtudiant> createState() => _ListeReclamations_etudiantState();
}

class _ListeReclamations_etudiantState extends State<ProfileEtudiant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 168, 198, 255),
     body: Center(child: Text("profile")),
    );
  }
}