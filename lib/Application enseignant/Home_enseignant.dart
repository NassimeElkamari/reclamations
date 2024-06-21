// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/details_reclamtion.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/menu/PasTraiter.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/menu/setting.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/menu/traiter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  List<Map<String, dynamic>> _reclamations = [];

  @override
  void initState() {
    super.initState();
    _loadEmail().then((_) {
      if (_emailProfessorConnecte != null) {
        _loadProfessorDetails(_emailProfessorConnecte!).then((_) {
          _loadReclamations();
        });
      }
    });
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
      String profileImageUrl = doc
          .get('profile'); // Assuming the URL field is named 'profileImageUrl'

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

  // Function to load reclamations from Firestore
  Future<void> _loadReclamations() async {
    if (_emailProfessorConnecte != null) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('reclamations')
          .where('email', isEqualTo: _emailProfessorConnecte)
          .get();
      setState(() {
        _reclamations = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    }
  }

  void _toggleSearch() {
    setState(() {
      isSearchClicked = !isSearchClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: isSearchClicked
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 227, 224, 231),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (context) {
                    // Handle search text changes here
                  },
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search,
                        color: const Color.fromARGB(255, 49, 35, 35)),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close, color: Colors.black),
                      onPressed: () {
                        setState(() {
                          searchController.clear();
                        });
                      },
                    ),
                  ),
                ),
              )
            : Text(
                "Home",
                style: TextStyle(
                  color: Color.fromARGB(255, 28, 51, 128),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  shadows: [
                    Shadow(
                      color:
                          Color.fromARGB(255, 207, 215, 240).withOpacity(0.5),
                      blurRadius: 6,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              _toggleSearch();
            },
            icon: Icon(Icons.search, color: Color.fromARGB(255, 28, 51, 128)),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Color.fromARGB(255, 10, 9, 9).withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10)
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 208, 227, 248),
              Color.fromARGB(255, 28, 51, 128),
            ],
          ),
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
            builder: (context) => DetailsReclamationPage(reclamationDetails: reclamation),
          ),
        );
                    },
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(
                          reclamation['sujet'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(reclamation['nomEtudiant']),
                        trailing: Icon(Icons.arrow_forward,
                            color: Color.fromARGB(255, 14, 118, 168)),
                      ),
                    ),
                  );
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
                    Color.fromARGB(255, 208, 227, 248),
                    Color.fromARGB(255, 28, 51, 128),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                /*  CircleAvatar(
                    radius: 50, // Augmente la taille de l'image
                    backgroundImage: _profileImageUrl != null
                        ? NetworkImage(_profileImageUrl!)
                        : AssetImage('assets/default_profile.png'),
                  ),*/
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
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Réclamation pas traitée',
                  style: TextStyle(color: Colors.black)),
              trailing: Icon(Icons.schedule, color: Colors.black),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => pastraiter()));
              },
            ),
            ListTile(
              title: Text('Réclamation traitée',
                  style: TextStyle(color: Colors.black)),
              trailing: Icon(Icons.check, color: Colors.black),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Traiter()));
               
                // Handle tap on Réclamation traitée
              },
            ),
            ListTile(
              title: Text('Paramètres', style: TextStyle(color: Colors.black)),
              trailing: Icon(Icons.settings, color: Colors.black),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Setting()));
                
                // Handle tap on Paramètres
              },
            ),
          ],
        ),
      ),
    );
  }
}
