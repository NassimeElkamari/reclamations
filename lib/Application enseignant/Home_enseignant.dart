// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/details_reclamtion.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/menu/non_trait%C3%A9es.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/menu/profile.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/menu/trait%C3%A9es.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/recamation_trait%C3%A9e.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/sign_in_enseignant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeEnseignant2 extends StatefulWidget {
  @override
  _HomeEnseignantState createState() => _HomeEnseignantState();
}

class _HomeEnseignantState extends State<HomeEnseignant2> {
  final TextEditingController searchController = TextEditingController();
  bool isSearchClicked = false;
  String? _emailProfessorConnecte;
  String? _nomProfessorConnecte;
  String? _profileImageUrl;
  int nonTreatedReclamationsCount = 0;

  List<Map<String, dynamic>> _reclamations = [];

  StreamSubscription<QuerySnapshot>? _reclamationsSubscription;

  @override
  void initState() {
    super.initState();
    _loadEmail().then((_) {
      if (_emailProfessorConnecte != null) {
        _loadProfessorDetails(_emailProfessorConnecte!).then((_) {
          _loadReclamations();
          _reclamationsSubscription = FirebaseFirestore.instance
              .collection('reclamations')
              .where('email', isEqualTo: _emailProfessorConnecte)
              .snapshots()
              .listen((querySnapshot) {
            setState(() {
              _reclamations = querySnapshot.docs.map((doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                data['Document ID'] = doc.id;
                return data;
              }).toList();
              nonTreatedReclamationsCount = _reclamations
                  .where((reclamation) => reclamation['status'] == false)
                  .length;
            });
          });
        });
      }
    });
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
      await prefs.remove('userType');
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
  void dispose() {
    _reclamationsSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailProfessorConnecte = prefs.getString('emailProfConnecte');
    });
  }

  Future<void> _loadProfessorDetails(String emailConnecte) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('enseignants')
        .where('email', isEqualTo: emailConnecte)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var doc = querySnapshot.docs.first;
      String nom = doc.get('nom');
      String prenom = doc.get('prenom');
      String profileImageUrl = doc.get('profile'); // Assuming the URL field is named 'profile'

      setState(() {
        _nomProfessorConnecte = '$nom $prenom';
        _profileImageUrl = profileImageUrl;
      });
    } else {
      setState(() {
        _nomProfessorConnecte = null;
        _profileImageUrl = null;
      });
    }
  }

  Future<void> _loadReclamations() async {
    if (_emailProfessorConnecte != null) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('reclamations')
          .where('email', isEqualTo: _emailProfessorConnecte)
          .get();
      setState(() {
        _reclamations = querySnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['Document ID'] = doc.id;
          return data;
        }).toList();
        nonTreatedReclamationsCount = _reclamations
            .where((reclamation) => reclamation['status'] == false)
            .length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Home",
          style: TextStyle(
            color: Color.fromARGB(255, 55, 105, 172),
            fontSize: 31,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            shadows: [
              Shadow(
                color: Color.fromARGB(255, 207, 215, 240).withOpacity(0.5),
                blurRadius: 6,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  // Handle notification icon tap
                },
                icon: Icon(Icons.notifications,
                    color: Color.fromARGB(255, 28, 51, 128)),
              ),
              if (nonTreatedReclamationsCount > 0)
                Positioned(
                  right: 11,
                  top: 11,
                  child: CircleAvatar(
                    radius: 8.0,
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    child: Text(
                      nonTreatedReclamationsCount.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white38,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Color.fromARGB(255, 10, 9, 9).withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10)
          ],
        ),
        child: _reclamations.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _reclamations.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> reclamation = _reclamations[index];
                  return GestureDetector(
                      onTap: () {
                        if (reclamation['status'] == false) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsReclamationPage(
                                reclamationDetails: reclamation,
                                reclamationId: reclamation['Document ID'],
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => reclamation_Traitee(
                                reclamationDetails: reclamation,
                                reclamationId: reclamation['Document ID'],
                              ),
                            ),
                          );
                        }
                      },
                      child: Card(
                        color: Color.fromARGB(255, 55, 105, 172),
                        elevation: 4,
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(
                            reclamation['sujet'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            reclamation['nomEtudiant'],
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward,
                            color: reclamation['status'] == true
                                ? Colors.green // Couleur pour status true
                                : Colors.red, // Couleur pour status false
                          ),
                        ),
                      ));
                },
              ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 55, 105, 172),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _profileImageUrl != null
                      ? CircleAvatar(
                          radius: 30, // Augmente la taille de l'image
                          backgroundImage: NetworkImage(_profileImageUrl!))
                      : CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                        ),
                  SizedBox(height: 10),
                  Text(
                    _nomProfessorConnecte != null
                        ? 'Pr. $_nomProfessorConnecte'
                        : '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _emailProfessorConnecte ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Color.fromARGB(255, 28, 51, 128),
              ),
              title: Text('profile'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileEnseignant()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.cancel_presentation_outlined,
                color: Color.fromARGB(255, 28, 51, 128),
              ),
              title: Text('Réclamations non traitées'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => non_traitees()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.check_box_outlined,
                color: Color.fromARGB(255, 28, 51, 128),
              ),
              title: Text('Réclamations traitées'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => traitees()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout_outlined,
                color: Color.fromARGB(255, 28, 51, 128),
              ),
              title: Text('Déconnexion '),
              onTap: () {
                _confirmLogout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
