
import 'package:flutter/material.dart';

class ListeReclamations extends StatelessWidget {
  const ListeReclamations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Réclamations ",
                style: TextStyle(
                    fontSize: 35, color: Color.fromARGB(255, 229, 232, 238))),
          ),
          backgroundColor: Color.fromRGBO(89, 139, 231, 1),
        ),
        body: Column(
          children: [
            Etudiant_card(),
            Etudiant_card(),Etudiant_card()
          ],
        ),
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
            color: Color.fromARGB(255, 16, 47, 105),
          ),
          selectedIcon: Icon(Icons.groups),
          label: 'Etudiants'),
      NavigationDestination(
          icon: Icon(Icons.check_circle_outline_outlined,
              color: Color.fromARGB(255, 16, 47, 105)),
          selectedIcon: Icon(Icons.check_circle),
          label: 'Reclamations'),
      NavigationDestination(
        icon:
            Icon(Icons.account_circle, color: Color.fromARGB(255, 16, 47, 105)),
        selectedIcon: Icon(Icons.account_circle),
        label: 'Profile',
      ),
    ],
  );
}

class Etudiant_card extends StatelessWidget {
  const Etudiant_card({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.all(30),
      height: 120,
      decoration: BoxDecoration(
          //color: Colors.pink[100],
          gradient: LinearGradient(
        colors: [
          Color.fromRGBO(89, 139, 231, 1),
          Color.fromRGBO(224, 235, 255, 1),
        ],
        begin: FractionalOffset.bottomLeft,
        end: FractionalOffset.topRight,
      ),
      borderRadius: BorderRadius.circular(45) ,
     // borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomLeft: Radius.circular(25))
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent, // Couleur transparente pour afficher le gradient du conteneur
            shadowColor: Color.fromARGB(0, 77, 128, 238), // Pas d'ombre pour le bouton
          ),
          onPressed: () {},
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              
              
              Row(
                children: [
                  Text(
                    "Sujet    :",
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 255, 255, 255)
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    "Vérification de note ",
                     style: TextStyle(
                      fontSize: 20,
                       color: Color.fromARGB(255, 36, 85, 192)
                    ),
                    )
                ],
              ),


              SizedBox(
                height: 5,
              ),


              Row(
                children: [
                  Text(
                    "Etudiant :",
                    style: TextStyle(
                      fontSize: 17,
                       color: Color.fromARGB(255, 255, 255, 255)
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    "Iman Abarkane ",
                     style: TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(255, 36, 85, 192)
                    ),
                    )
                ],
              ),



              SizedBox(
                height: 8,
              ),

              Row(
                children: [
                  Text(
                    "Date        :",
                    style: TextStyle(
                      fontSize: 17,
                       color: Color.fromARGB(255, 255, 255, 255)
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    "03/01/2024 ",
                     style: TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(255, 36, 85, 192)
                    ),
                    )
                ],
              ),
              

            ],
          )),
    );
  }
}
