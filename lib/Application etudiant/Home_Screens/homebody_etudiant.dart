// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_print, sized_box_for_whitespace, use_build_context_synchronously

import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/AjouterReclamation.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/apropos_application.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/liste_des_cours.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/mesReclamations.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/auth/login.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/liste_sites_facult%C3%A9.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBodyEtudiant extends StatefulWidget {
  const HomeBodyEtudiant({Key? key}) : super(key: key);

  @override
  State<HomeBodyEtudiant> createState() => _HomeBodyEtudiantState();
}

class _HomeBodyEtudiantState extends State<HomeBodyEtudiant> {
  String? studentName;
  String? apogeConnecte;

  @override
  void initState() {
    super.initState();
    _loadApoge();
  }

//la fonction de deconnexion
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut(); // Déconnexion de Firebase Auth
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(
          'apogeConnecte'); // Suppression de l'apogée dans SharedPreferences
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Login()), // Assurez-vous que LoginPage() est correctement importé
      );
      //  print("connexion reussite !!!!:)  pour " + nom + "  " + prenom);
    } catch (e) {
      print('Erreur lors de la déconnexion : $e');
    }
  }

  Future<void> _loadApoge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apoge = prefs.getString('apogeConnecte');
    if (apoge != null) {
      print(
          'Apoge trouvé dans SharedPreferences: $apoge'); // Debug: Afficher l'apoge trouvé
      _searchStudentByApoge(apoge);
    } else {
      print('Aucun apoge trouvé dans SharedPreferences');
    }
  }

  Future<void> _searchStudentByApoge(String apoge) async {
    try {
      print(
          'Recherche de l\'étudiant avec l\'apoge: $apoge'); // Debug: Afficher l'apoge utilisé pour la recherche
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('etudiantsActives')
          .where('apoge', isEqualTo: apoge)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var studentDoc = querySnapshot.docs.first;
        setState(() {
          studentName = studentDoc['prenom'] + ' ' + studentDoc['nom'];
        });
        print(
            'Étudiant trouvé: $studentName'); // Debug: Afficher le nom de l'étudiant trouvé
      } else {
        print('Aucun étudiant trouvé avec l\'apoge: $apoge');
      }
    } catch (e) {
      print('Erreur lors de la recherche de l\'étudiant avec l\'apoge: $e');
    }
  }

  // Fonction pour ouvrir le site web
  Future<void> openAppBrowserView(String url) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(width: 110),
            Text(
              " Accueil",
              style: TextStyle(
                fontSize: 36,
                color: Color.fromARGB(255, 228, 240, 255),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 84, 132, 196),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Color.fromARGB(255, 228, 240, 255),
            ),
            onPressed: () {
              showMenu(
                color: Color.fromARGB(255, 228, 240, 255),
                context: context,
                position: RelativeRect.fromLTRB(100, 100, 0, 0),
                items: [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text(
                      "Paramètres",
                      style: TextStyle(
                        color: Color.fromARGB(255, 55, 105, 172),
                      ),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text(
                      "Guide d'utilisation",
                      style: TextStyle(
                        color: Color.fromARGB(255, 55, 105, 172),
                      ),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Text(
                      "Corbeille",
                      style: TextStyle(
                        color: Color.fromARGB(255, 55, 105, 172),
                      ),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 3,
                    child: Text(
                      "À propos de l'application",
                      style: TextStyle(
                        color: Color.fromARGB(255, 55, 105, 172),
                      ),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 4,
                    child: Text(
                      "Déconnexion",
                      style: TextStyle(
                        color: Color.fromARGB(255, 55, 105, 172),
                      ),
                    ),
                  ),
                ],
                elevation: 8.0,
              ).then((value) {
                if (value == 0) {
                  // Action pour l'option "Paramètres"
                  
                  print('Option "Paramètres" sélectionnée');
                } else if (value == 1) {
                  // Action pour l'option "Guide d'utilisation"
                  print('Option "Guide d\'utilisation" sélectionnée');
                } else if (value == 2) {
                  // Action pour l'option "Corbeille"
                  print('Option "Corbeille" sélectionnée');
                } else if (value == 3) {
                  // Action pour l'option "À propos de l'application"
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AproposApplication(),
                      ));

                  print('Option "À propos de l\'application" sélectionnée');
                } else if (value == 4) {
                  _logout(); // Appel de la fonction de déconnexion
                  print('Option "Déconnexion" sélectionnée');
                }
              });
            },
          )
        ],
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          SizedBox(height: 15),

          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    studentName != null
                        ? 'Bonjour $studentName !'
                        : 'Chargement...',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 84, 132, 196),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            height: 80,
            width: double.infinity,
          ),
          SizedBox(height: 10),

          Image.asset(
            "images/acceuil_etudiant.png",
            height: 200,
          ),

          SizedBox(height: 30),

          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(width: 16),
                // liste des réclamations
                Cas_Utilisation(context, "images/mes reclamations.png",
                    " mes réclamations ", () => MesReclamations(), 112),
                SizedBox(width: 16),
                // liste des cours

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListedesCours(),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 153, 182, 255)
                              .withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 84, 132, 196),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 6),
                        Image.asset("images/mescours.png", height: 110),
                        SizedBox(height: 5),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Liste des cours",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 242, 245, 255),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                // liste des offres travail pour les étudiants
                GestureDetector(
                  onTap: () {
                    openAppBrowserView('https://www.emploi.ma');
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 153, 182, 255)
                              .withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 84, 132, 196),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 6),
                        Image.asset("images/offres_enmplois.png", height: 100),
                        SizedBox(height: 6),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Voir des offres d'emploi",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 242, 245, 255),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                // open page facultes des sciences
                GestureDetector(
                  onTap: () {
                    openAppBrowserView('https://www.fst.ac.ma/site');
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 153, 182, 255)
                              .withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 84, 132, 196),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 6),
                        Image.asset("images/actualités_faculte.png",
                            height: 100),
                        SizedBox(height: 6),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Les actualités de la faculté",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 242, 245, 255),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                // liste des applications liee a la facultes
                Cas_Utilisation(context, "images/acces_aux_sites.png",
                    "Accès aux sites de la faculté", () => SitesFaculte(), 100),
                SizedBox(width: 16),
              ],
            ),
          ),
          SizedBox(height: 30),
          // button ajouter reclamations
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 84, 132, 196),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AjouterReclamation(),
                    ),
                  );
                },
                child: Icon(Icons.add),
              ),
            ),
          ),
          SizedBox(height: 70),
        ],
      ),
    );
  }

  GestureDetector Cas_Utilisation(BuildContext context, String imagePath,
      String title, Widget Function() chemin, double size) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => chemin(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        height: 100,
        width: 200,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 153, 182, 255).withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 84, 132, 196),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 6),
            Image.asset(imagePath, height: size),
            SizedBox(height: 6),
            Container(
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 242, 245, 255),
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
