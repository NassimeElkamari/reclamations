// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors


import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/liste_reclamations.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/profile_etudiant.dart';
import 'package:application_gestion_des_reclamations_pfe/widgets/Home_etudiant_body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';


class HomeEtudiant extends StatefulWidget {
  const HomeEtudiant({super.key});

  @override
  State<HomeEtudiant> createState() => _HomeEtudiantState();
}

List Screens =[
    HomeEtudiant(),
    ListeReclamations_etudiant(),
    ProfileEtudiant(),

    
];
int _selecedIndex=0;

class _HomeEtudiantState extends State<HomeEtudiant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(255, 168, 198, 255),
      appBar: homeAppBar(),
     body: HomeEtudiantBody(),

      
    ) ;
  }

 

  AppBar homeAppBar() {
    return AppBar(
     backgroundColor: Color.fromARGB(255, 168, 198, 255),
       title: Center(
        child: Text(
        'Acceuil',
        style: TextStyle(
          fontSize: 35,
          color: const Color.fromARGB(255, 255, 255, 255)
        ),

       )),
       actions: [
        IconButton(
          onPressed: (){}, 
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
           )
          ),
        
       ],
       leading: IconButton(
        onPressed: (){}, 
        icon:Icon(
          Icons.menu,
          color: Colors.white,
          )
        ),
    );
  }
}