// ignore_for_file: unused_import

import 'package:flutter/material.dart';

class Etudiant {
  int apoge;
  String nom;
  String prenom;
  String filliere;
  String email;
  int cin;

  Etudiant({
    required this.apoge,
    required this.cin,
    required this.nom,
    required this.prenom,
    required this.filliere,
    required this.email,
  });
}

List<Etudiant> etudiants = [
  Etudiant(
    apoge: 12345,
    cin:20023,
    nom: "abarkane",
    prenom: "iman",
    filliere: "Informatique",
    email: "imanabarkane@example.com",
  ),
  Etudiant(
    apoge: 54321,
    cin:20023,
    nom: "Smith",
    prenom: "fofo",
    filliere: "Génie civil",
    email: "imano03@example.com",
  ),
  // Ajoutez d'autres étudiants au besoin
];