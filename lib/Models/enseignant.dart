import 'package:flutter/material.dart';

class Enseignant {
  String nom;
  String prenom;
  String filliere;
  String email;
  String cin;

  Enseignant({
    required this.cin,
    required this.nom,
    required this.prenom,
    required this.filliere,
    required this.email,
  });
}

List<Enseignant> enseignants = [
  Enseignant(
      cin: "le1234",
      nom: "abdoun",
      prenom: "othman",
      filliere: "smi",
      email: "othmanabdoun@gmail.com",
      ),
      Enseignant(
      cin: "ll568942",
      nom: "elmhouti",
      prenom: "abderrahim",
      filliere: "smi",
      email: "elmhoutiabdelrahim@gmail.com",
      ),
      Enseignant(
      cin: "le12852",
      nom: "amjad",
      prenom: "souad",
      filliere: "smi",
      email: "amjadsouad@gmail.com",
      ),
      Enseignant(
      cin: "lg69874",
      nom: "adnan",
      prenom: "souri",
      filliere: "sma",
      email: "adnansouri@gmail.com",
      ),
      

];
