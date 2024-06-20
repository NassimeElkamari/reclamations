// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/ButtomnavigatorBar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SitesFaculte extends StatefulWidget {
  const SitesFaculte({super.key});

  @override
  State<SitesFaculte> createState() => _SitesFaculteState();
}

class _SitesFaculteState extends State<SitesFaculte> {
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
        toolbarHeight: 80,
        backgroundColor: Color.fromARGB(255, 55, 105, 172),
        /* leading: IconButton(
          //button pour retour a la page principale
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NavigatorBarEtudiant(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),*/
        title: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "des sites programmées ",
                style: TextStyle(
                    fontSize: 21,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "par la faculté",
                style: TextStyle(
                    fontSize: 21,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(
                    10), // Ajouter un peu de marge autour du bouton
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 55, 105, 172),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Coins légèrement arrondis
                        side: BorderSide(
                          color: Color.fromARGB(255, 238, 116, 17),
                        ), // Bordure bleue
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0), // Espacement interne du bouton
                    ),
                  ),
                  onPressed: () {
                    openAppBrowserView('https://moodle.fst.ac.ma/moodle');
                  },
                  child: const Text(
                    'la plateforme Moodle de la Faculté',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 55, 105, 172),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Coins légèrement arrondis
                      side: BorderSide(
                        color: Color.fromARGB(255, 238, 116, 17),
                      ), // Bordure de couleur personnalisée
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0, // Espacement interne du bouton
                    ),
                  ),
                ),
                onPressed: () {
                  // Logique à exécuter lors de l'appui sur le bouton
                },
                child: const Text(
                  "La Plateforme D'apprentissage Des \n  langues Rosetta Stone Via SSO",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(
                    10), // Ajouter un peu de marge autour du bouton
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 55, 105, 172),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Coins légèrement arrondis
                        side: BorderSide(
                          color: Color.fromARGB(255, 238, 116, 17),
                        ), // Bordure bleue
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0), // Espacement interne du bouton
                    ),
                  ),
                  onPressed: () {
                    openAppBrowserView('https://apoweb-te.uae.ac.ma/dossier_etudiant_fs_tetouan');
                  },
                  child: const Text(
                    "Site d'ffichage des notes",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              //affichage des notes
                    ],
          ),
        ),
      ),
    );
  }
}
