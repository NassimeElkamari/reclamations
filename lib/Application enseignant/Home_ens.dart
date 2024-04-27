// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ensHomePage extends StatefulWidget {
  @override
  _ensHomePageState createState() => _ensHomePageState();
}

class _ensHomePageState extends State<ensHomePage> {
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
        centerTitle: true,
        title: isSearchClicked
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 104, 126, 158),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (context) {
                    // Gérez les changements de texte de recherche ici
                  },
                  decoration: InputDecoration(
                    hintText: 'Search reclamtion...',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          searchController.clear();
                        });
                      },
                    ),
                  ),
                ),
              )
            : Text("Search"),
        actions: [
          IconButton(
            onPressed: () {
              _toggleSearch();
            },
            icon: Icon(Icons.search),
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
                trailing: Icon(Icons.arrow_forward),
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
                pastraite();
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
              title: Text('Déconnexion'),
              trailing: Icon(Icons.login),
              onTap: () {
                // Action à effectuer lors du clic sur Déconnexion
              },
            ),
            ListTile(
              title: Text('Paramètres'),
              trailing: Icon(Icons.settings),
              onTap: () {
                // Action à effectuer lors du clic sur Paramètres
              },
            ),
          ],
        ),
      ),
    );
  }
}
