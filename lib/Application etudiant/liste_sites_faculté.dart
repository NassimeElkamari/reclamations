
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors


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
        title: Text("des sites programmées par la faculté"),
      ),
      body: Container(
        decoration: BoxDecoration(
           gradient: LinearGradient(
           colors: [
             Color.fromARGB(255, 99, 147, 250),
             Color.fromARGB(255, 243, 204, 243),
           ]
         )
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                   openAppBrowserView('https://moodle.fst.ac.ma/moodle');
                  },
                  child: const Text(
                    'la plateforme Moodle de la Faculté',
                    style: TextStyle(color: Colors.white),
                  )),
        
                  SizedBox(
                    height: 40,
                  ),
              ElevatedButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                  /* Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>lirePdf(),
                      ),
                    );*/
                  },
                  child: const Text(
                    "La Plateforme D'apprentissage Des Langues Rosetta Stone Via SSO",
                    style: TextStyle(color: Colors.white),
                  )),
        
        
                  SizedBox(
                    height: 40,
                  ),
        
        
                  //affichage des notes 
              ElevatedButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                   openAppBrowserView('https://apoweb-te.uae.ac.ma/dossier_etudiant_fs_tetouan');
                  },
                  child: const Text(
                    'Affichage des notes ',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}