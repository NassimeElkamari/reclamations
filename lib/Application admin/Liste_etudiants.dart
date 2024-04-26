import 'package:application_gestion_des_reclamations_pfe/Application%20admin/etudiant_details.dart';
import 'package:flutter/material.dart';

class ListeEtudiants extends StatelessWidget {
  const ListeEtudiants({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Acceuil",
            style: TextStyle(
              fontSize: 40,
              color: Color.fromARGB(255, 16, 51, 126)
            )
            ),
          ),
          backgroundColor: Color.fromRGBO(89, 139, 231, 1),
        ),
        body: Etudiant_card(),
        bottomNavigationBar: navigatorbar_fonction());
  }
}

NavigationBar navigatorbar_fonction() {
  return NavigationBar(
    height: 70,
    destinations: [
      NavigationDestination(
          icon: Icon(
            Icons.check_circle_outline_outlined,
            color:Color.fromARGB(255, 16, 47, 105),
            ),

          selectedIcon: Icon(Icons.groups),
          label: 'Etudiants'),
      NavigationDestination(
          icon: Icon(Icons.check_circle_outline_outlined,color:Color.fromARGB(255, 16, 47, 105)),
          selectedIcon: Icon(Icons.check_circle),
          label: 'Reclamations'),
      NavigationDestination(
          icon: Icon(Icons.account_circle,color:Color.fromARGB(255, 16, 47, 105)),
          selectedIcon: Icon(Icons.account_circle),
          label: 'Profile',),
    ],
  );
}

class Etudiant_card extends StatelessWidget {
  const Etudiant_card({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      height: 60,
      decoration: BoxDecoration(
        //color: Colors.pink[100],
         gradient: LinearGradient(
            colors: [
              Color.fromRGBO(89, 139, 231, 1),
              Color.fromRGBO(255, 255, 255, 1),
            ],
            begin: FractionalOffset.bottomLeft,
            end: FractionalOffset.topRight,
          )
         ),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Icon(Icons.person),
          SizedBox(
            width: 20,
          ),
          Text("Iman Abarkane",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Color.fromARGB(255, 81, 109, 156))),
          SizedBox(
            width:50,
          ),
          Container(
            height: 60,
            width: 70,
            color: Color.fromARGB(255, 213, 221, 243),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Etudiant_details()), // Remplacez EtudiantDetails() par la page de destination
                );
              },
              icon: Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
    );
  }
}











/*Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Action lorsque le deuxième accepter est pressé
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Accepter"),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action lorsque le deuxième refuser est pressé
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Refuser"),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),*/