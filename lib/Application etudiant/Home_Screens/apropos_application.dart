// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class AproposApplication extends StatefulWidget {
  const AproposApplication({super.key});

  @override
  State<AproposApplication> createState() => _AproposApplicationState();
}

class _AproposApplicationState extends State<AproposApplication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 84, 132, 196),
        title: Center(
          child: Text(
            "À propos de notre application",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "    Notre application mobile est une plateforme innovante conçue pour faciliter la gestion des réclamations des étudiants de la Faculté des Sciences de Tétouan. Développée par Iman Abarkane et Nihad Khattabi dans le cadre de leur projet de fin d'études en Licence Fondamentale en Informatique, cette application vise à simplifier le processus de réclamation en offrant aux étudiants et au personnel administratif un outil efficace et intuitif. Le développement de l'application de gestion des réclamations de notes jouera un rôle important dans la réduction des problèmes actuels en apportant plusieurs améliorations significatives:",
              style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 55, 105, 172)),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "1. Simplifier le processus :",
                    style: TextStyle(color: Color.fromARGB(255, 238, 116, 17), fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: " L’application offre aux étudiants une plateforme conviviale et interactive pour soumettre leurs réclamations de manière transparente et une interface utilisateur intuitive pour le système de gestion des réclamations, permettant de naviguer facilement et de déposer les réclamations sans difficulté.",
                    style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 55, 105, 172)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "2. Réduire les délais de traitement :",
                    style: TextStyle(color: Color.fromARGB(255, 238, 116, 17), fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: " En améliorant ainsi la réactivité et la satisfaction des étudiants par l'identification et la suppression de toute étape redondante ou non essentielle du processus, simplifiant ainsi le parcours et accélérant la résolution.",
                    style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 55, 105, 172)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "3. Uniformiser la procédure :",
                    style: TextStyle(color: Color.fromARGB(255, 238, 116, 17), fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: " Entre les départements sera également un objectif clé, assurant une gestion cohérente et équitable des réclamations à travers l'institution académique.",
                    style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 55, 105, 172)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "4. Faciliter la communication :",
                    style: TextStyle(color: Color.fromARGB(255, 238, 116, 17), fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: " Entre les étudiants, les enseignants et les administratifs sera grandement améliorée, en mettant en place une plateforme de communication spécialisée qui permet aux étudiants, aux enseignants et au personnel administratif de communiquer facilement et rapidement.",
                    style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 55, 105, 172)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "5. Minimiser les erreurs humaines :",
                    style: TextStyle(color: Color.fromARGB(255, 238, 116, 17), fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: " En réduisant le risque de perte de documents personnels et en assurant l'intégrité des informations liées aux réclamations. En permettant aux étudiants de fournir des détails spécifiques sur leurs réclamations, l'application favorisera une communication précise et détaillée, facilitant ainsi le traitement efficace des demandes.",
                    style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 55, 105, 172)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
