// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/menu/setting.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/menu/traiter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeEnseignant extends StatefulWidget {
  const HomeEnseignant({Key? key}) : super(key: key);

  @override
  State<HomeEnseignant> createState() => _HomeEnseignantState();
}

class _HomeEnseignantState extends State<HomeEnseignant> {
  final TextEditingController searchController = TextEditingController();
  bool isSearchClicked = false;

  void _toggleSearch() {
    setState(() {
      isSearchClicked = !isSearchClicked;
    });
  }

  void pastraite() {
    // Action à effectuer lors du clic sur Réclamation pas traitée
    print('Traitement des réclamations pas traitées...');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: isSearchClicked
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 243, 244),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (context) {
                    // Gérez les changements de texte de recherche ici
                  },
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.black),
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
            : Text("home", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            onPressed: () {
              _toggleSearch();
            },
            icon: Icon(Icons.search, color: Colors.black),
          ),
        ],
      ),
      body: ListView.builder(
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 14, 118, 168),
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
              title: Text('Déconnexion', style: TextStyle(color: Colors.black)),
              trailing: Icon(Icons.login, color: Colors.black),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "LoginEnseignant", (route) => false);
              },
            ),
            ListTile(
              title: Text('Paramètres', style: TextStyle(color: Colors.black)),
              trailing: Icon(Icons.settings, color: Colors.black),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => setting()));
                // Action à effectuer lors du clic sur Paramètres
              },
            ),
          ],
        ),
      ),
    );
  }
}
