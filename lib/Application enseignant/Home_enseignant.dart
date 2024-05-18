import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/menu/setting.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/menu/traiter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeEnseignant extends StatefulWidget {
  const HomeEnseignant({Key? key}) : super(key: key);

  @override
  State<HomeEnseignant> createState() => _HomeEnseignantState();
}

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getEnseignantInfo(String uid) async {
    return await _firestore.collection('enseignants').doc(uid).get();
  }
}

class _HomeEnseignantState extends State<HomeEnseignant> {
  final TextEditingController searchController = TextEditingController();
  bool isSearchClicked = false;
  final _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  late User signedInUser;
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        final snapshot = await _firestoreService.getEnseignantInfo(user.uid);
        if (snapshot.exists) {
          setState(() {
            profileImageUrl = snapshot['profile'];
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

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
                    backgroundImage: profileImageUrl != null
                        ? NetworkImage(profileImageUrl!)
                        : AssetImage('assets/profile_pic.jpg') as ImageProvider,
                  ),
                  SizedBox(height: 10),
                  Text(
                    signedInUser.email ?? 'Nom de l\'enseignant',
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
