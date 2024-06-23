// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/details_reclamtion.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/menu/profile.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class non_traitees extends StatefulWidget {
  @override
  _non_traiteesState createState() => _non_traiteesState();
}

class _non_traiteesState extends State<non_traitees> {
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
              nonTreatedReclamationsCount = _reclamations.where((reclamation) => reclamation['status'] == false).length;
            });
          });
        });
      }
    });
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
      String profileImageUrl = doc.get('profile'); // Assuming the URL field is named 'profileImageUrl'

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
          .where('status', isEqualTo: false)
          .get();
      setState(() {
        _reclamations = querySnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['Document ID'] = doc.id;
          return data;
        }).toList();
        nonTreatedReclamationsCount = _reclamations.where((reclamation) => reclamation['status'] == false).length;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Reclamations \n non traitées",
          style: TextStyle(
            color: Color.fromARGB(255, 238, 116, 17),
            fontSize: 25,
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
                      
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsReclamationPage(
                                reclamationDetails: reclamation,
                                reclamationId: reclamation['Document ID'],
                              ),
                            ),
                          );
                       
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
     
    );
  }
}
