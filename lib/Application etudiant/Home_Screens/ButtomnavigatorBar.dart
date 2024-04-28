// ignore_for_file: prefer_final_fields, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/Home_etudiant.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/liste_reclamations.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/profile_etudiant.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class NavigatorBarEtudiant extends StatefulWidget {
  const NavigatorBarEtudiant({super.key});

  @override
  State<NavigatorBarEtudiant> createState() => _NavigatorBarEtudiantState();
}

class _NavigatorBarEtudiantState extends State<NavigatorBarEtudiant> {
  List Screens = [
    HomeEtudiant(),
    ListeReclamations_etudiant(),
    ProfileEtudiant(),
  ];
  int _selecedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Color.fromARGB(255, 88, 146, 255),
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
          Icon(Icons.home,size: 30),
          Icon(Icons.favorite,size: 30),
          Icon(Icons.person,size: 30,),
          // IconButton(onPressed: (){}, icon:Icons.check_circle_outline_outlined )
        ],
      ),
      body: Screens[_selecedIndex],
    );
  }
}
