// ignore_for_file: prefer_const_constructors

import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/sign_in_enseignant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileEns extends StatelessWidget {
  const ProfileEns({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String nom = '';
  late String prenom = '';
  late String email = '';
  late String filiere = '';
  late String profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    loadProfil();
  }

  List<QueryDocumentSnapshot> data = [];

  loadProfil() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final docRef =
          FirebaseFirestore.instance.collection('enseignants').doc(userId);
      final docSnap = await docRef.get();
      if (docSnap.exists) {
        final data = docSnap.data();
        setState(() {
          nom = data?['nom'] ?? '';
          prenom = data?['prenom'] ?? '';
          email = data?['email'] ?? '';
          filiere = data?['filiere'] ?? '';
          profileImageUrl = data?['profile'] ?? '';
        });
      }
    }
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            SignInEnseignant(), // Replace with your login screen
      ));
    } catch (e) {
      print("Error during sign out: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la déconnexion. Veuillez réessayer.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Êtes-vous sûr de vouloir vous déconnecter?'),
          actions: [
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Déconnexion'),
              onPressed: () {
                Navigator.of(context).pop();
                _logout(context);
              },
            ),
          ],
        );
      },
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 55, 105, 172),
          ]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              CircleAvatar(
                radius: 70,
                backgroundImage: profileImageUrl.isNotEmpty
                    ? NetworkImage(profileImageUrl)
                    : AssetImage('assets/images/user.JPG') as ImageProvider,
              ),
              const SizedBox(height: 20),
              itemProfile(nom, CupertinoIcons.person),
              const SizedBox(height: 10),
              itemProfile(prenom, CupertinoIcons.person),
              const SizedBox(height: 10),
              itemProfile(email, CupertinoIcons.mail),
              const SizedBox(height: 10),
              itemProfile(filiere, CupertinoIcons.briefcase),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _confirmLogout(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text('Déconnexion'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget itemProfile(String data, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.deepOrange.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          )
        ],
      ),
      child: ListTile(
        subtitle: Text(data),
        leading: Icon(iconData),
        trailing: const Icon(Icons.arrow_forward, color: Colors.grey),
        tileColor: Colors.white,
      ),
    );
  }
}
