
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/gestion%20enseignant/liste_enseignants.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/gestion%20etudiants/liste_etudiants.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/gestion%20reclamation/liste_reclamations.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20admin/profileAdmin.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class NavigatorBarAdmin extends StatefulWidget {
  const NavigatorBarAdmin({super.key});

  @override
  State<NavigatorBarAdmin> createState() => _NavigatorBarEtudiantState();
}

class _NavigatorBarEtudiantState extends State<NavigatorBarAdmin> {
  List Screens = [
    ListeDesReclamations(),
    ListeDesEtudiants(),
    ListeDesEnseignants(),
     AdminProfilePage(),

  ];
  int _selecedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Color.fromARGB(255, 55, 105, 172),
        height: 60,
        animationDuration: Duration(milliseconds: 300),
        index: _selecedIndex,
        onTap: (index) {
          setState(() {
            _selecedIndex = index;
          });
          print(index);
        },
       
        items: [
          Icon(
            Icons.article,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.school,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.group,
            size: 30,
            color: Colors.white,
          ),
          Icon(Icons.account_circle_rounded, size: 30,color: Colors.white,),
        ],
      ),
      body: Screens[_selecedIndex],
    );
  }
}