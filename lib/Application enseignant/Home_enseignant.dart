// ignore_for_file: use_super_parameters, prefer_const_literals_to_create_immutables, unnecessary_cast, prefer_const_constructors, unused_field, unused_import


import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/menu/setting.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/menu/traiter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeEnseignant extends StatefulWidget {
  const HomeEnseignant({Key? key}) : super(key: key);

  @override
  State<HomeEnseignant> createState() => _HomeEnseignantState();
}

class _HomeEnseignantState extends State<HomeEnseignant> {
  final TextEditingController searchController = TextEditingController();
  bool isSearchClicked = false;
  final _auth = FirebaseAuth.instance;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email');
    });
  }

  _saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }

  void _toggleSearch() {
    setState(() {
      isSearchClicked =!isSearchClicked;
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
                    // Gérez les changements de texte de recherche ici
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
                  color: Colors.black,
                  fontSize: 23, // Taille du texte
                  fontWeight: FontWeight.bold, // Gras
                  fontFamily: 'Roboto', // Police personnalisée
                  shadows: [
                    Shadow(
                      color: const Color.fromARGB(255, 188, 78, 78)
                          .withOpacity(0.5), // Couleur de l'ombre
                      blurRadius: 6, // Rayon du flou
                      offset: Offset(2, 2), // Décalage de l'ombre
                    ),
                  ],
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              _toggleSearch();
            },
            icon: Icon(Icons.search,
                color: const Color.fromARGB(255, 62, 39, 39)),
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
              Color.fromARGB(255, 188, 154, 199),
              Color.fromARGB(255, 138, 103, 178),
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: 6, // Nombre de réclamations à afficher
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                // Action à effectuer lors du clic sur une réclamation
              },
              child: Card(
                elevation: 4,
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    'Réclamation ${index + 1}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Contenu de la réclamation...'),
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
            // ignore: prefer_const_constructors
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 188, 154, 199),
                    Color.fromARGB(255, 110, 81, 143),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('profile'),
                  ),
                  SizedBox(height: 10),
                  Text(
                   _email?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
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
                    MaterialPageRoute(builder: (context) => Traiter()));
              },
            ),
            ListTile(
              title: Text('Réclamation traitée',
                  style: TextStyle(color: Colors.black)),
              trailing: Icon(Icons.check, color: Colors.black),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Traiter()));
                // Action à effectuer lors du clic sur Réclamation traitée
              },
            ),
            ListTile(
              title: Text('Paramètres', style: TextStyle(color: Colors.black)),
              trailing: Icon(Icons.settings, color: Colors.black),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Setting()));
                // Action à effectuer lors du clic sur Paramètres
              },
            ),
          ],
        ),
      ),
    );
  }
}
