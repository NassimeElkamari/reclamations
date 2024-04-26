// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors


import 'package:application_gestion_des_reclamations_pfe/widgets/Home_etudiant_body.dart';
import 'package:flutter/material.dart';


class HomeEtudiant extends StatelessWidget {
  const HomeEtudiant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Color.fromARGB(95, 91, 133, 250),
      appBar: homeAppBar(),
     body: HomeEtudiantBody(),
     //HomeBody(),
      bottomNavigationBar: navigatorbar_fonction(),
    ) ;
  }

  NavigationBar navigatorbar_fonction() {
    return NavigationBar(
      height: 70,
      destinations: [
        NavigationDestination
        (icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
         label: 'Home'
         ),
        /* NavigationDestination
        (icon: Icon(Icons.add_box_outlined),
        selectedIcon: Icon(Icons.add_box_outlined),
         label: 'Add'
         ),*/
         NavigationDestination
        (icon: Icon(Icons.check_circle_outline_outlined),
        selectedIcon: Icon(Icons.home),
         label: 'Vlides '
         ),
         NavigationDestination
        (icon: Icon(Icons.account_circle),
        selectedIcon: Icon(Icons.power_off_outlined),
         label: 'Profile'
         ),

      ],
    );
  }

  AppBar homeAppBar() {
    return AppBar(
      backgroundColor:  Color.fromARGB(255, 150, 207, 245),
       title: Center(
        child: Text(
        'Acceuil',
        style: TextStyle(
          fontSize: 35,
          color: const Color.fromARGB(255, 255, 255, 255)
        ),

       )),
       actions: [
        IconButton(
          onPressed: (){}, 
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
           )
          ),
        
       ],
       leading: IconButton(
        onPressed: (){}, 
        icon:Icon(
          Icons.menu,
          color: Colors.white,
          )
        ),
    );
  }
}