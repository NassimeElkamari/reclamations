// ignore_for_file: prefer_const_constructors

import 'package:application_gestion_des_reclamations_pfe/Application%20commune/Welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminProfilePage extends StatefulWidget {
  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  bool isLoggedIn = true;

 Future<void> _logout(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Déconnexion',
          style: TextStyle(
            color: Color.fromARGB(255, 28, 51, 128),
          ),
        ),
        content: Text('Voulez-vous vraiment vous déconnecter?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Annuler',
              style: TextStyle(
                color: Color.fromARGB(255, 28, 51, 128),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              // Déconnexion de Firestore (aucune méthode signOut nécessaire)
              // Réinitialisez les données d'authentification ou tout autre état utilisateur si nécessaire
              setState(() {
                isLoggedIn = false;
              });
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
              );
            },
            child: Text(
              'Déconnecter',
              style: TextStyle(
                color: Color.fromARGB(255, 28, 51, 128),
              ),
            ),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "  Admin profil",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 28, 51, 128),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: SizedBox(
                    width: 200,
                    height: 160,
                    child: Image.asset(
                      'images/LOGO fs.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 28, 51, 128),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Admin',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 28, 51, 128),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            ListTile(
              leading:
                  Icon(Icons.logout, color: Color.fromARGB(255, 28, 51, 128)),
              title: Text(
                'Déconnexion',
                style: TextStyle(color: Color.fromARGB(255, 28, 51, 128)),
              ),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
    );
  }
}
