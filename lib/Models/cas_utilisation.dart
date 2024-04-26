

// ignore_for_file: unused_import, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';


class Cas_Utilisation {


  final String title,subTitle ,image;


  Cas_Utilisation({
    required this.title,
    required this.subTitle,
    required this.image
  });

}

  
  List<Cas_Utilisation>liste_fonctions= [
   Cas_Utilisation(
    title: "Liste des réclamations ", 
    subTitle: "Consultez la liste des réclamations en cours si vous avez des questions ou des problèmes à signaler.",
     image:"images/1.png"),


     Cas_Utilisation(
    title: "liste des cours", 
    subTitle:  "Accédez à la liste des cours disponibles pour la session en cours.",
     image: "images/2.png"),



     Cas_Utilisation(
    title: "Avoir une attestation", 
    subTitle: "Obtenez une attestation officielle pour diverses fins administratives.",
     image: "images/3.png"),


     Cas_Utilisation(
    title: "Demander un stage ", 
    subTitle: "Soumettez une demande de stage pour acquérir de l'expérience professionnelle.",
     image: "images/4.png"),


     Cas_Utilisation(
    title: "Consulter les offres d'emploi", 
    subTitle: "Consultez les offres d'emploi disponibles pour les étudiants de la faculté des sciences à Tetouan.",
     image: "images/5.png")

  ];
  
