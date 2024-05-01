// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors


import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/homebody_etudiant.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/liste_reclamations.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/profile_etudiant.dart';
import 'package:application_gestion_des_reclamations_pfe/widgets/Home_etudiant_body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
     backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: homeAppBar(),
     body: HomeBodyEtudiant(),
     drawer: Drawer(
      child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 106, 187, 254),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/profile_pic.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nom de l\'enseignant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Adresse e-mail de l\'enseignant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Réclamation pas traitée'),
              trailing: Icon(Icons.schedule),
              onTap: () {
                
              },
            ),
            ListTile(
              title: Text('Réclamation traitée'),
              trailing: Icon(Icons.check),
              onTap: () {
                // Action à effectuer lors du clic sur Réclamation traitée
              },
            ),
            
            ListTile(
              title: Text('Paramètres'),
              trailing: Icon(Icons.settings),
              onTap: () {
                // Action à effectuer lors du clic sur Paramètres
              },
            ),
            ListTile(
              title: Text('Déconnexion'),
              trailing: Icon(Icons.login),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil("LoginEnseignant", (route) => false);
              },
            ),
          ],
        ),

     ),
      
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
       
    );
  }
}